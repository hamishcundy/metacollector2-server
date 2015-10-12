class ParticipantsController < ApplicationController



  before_action :authenticate_user!
  before_action :get_participant, :except => [:index]

  def timeline_data
    master_array = Array.new
    


    sms_dates = @participant.sms_log_records.pluck(:date)
    sms_array = Array.new
    imin = 99999999999999
    imax = 0
    sms_dates.each do |d|
      sms_array << {:starting_time => d / 1000, :display => "circle"}
      if d > imax
        imax = d
      end
      if d < imin
        imin = d
      end

    end
    master_array << {:label => "SMS", :times => sms_array}

    respond_to do |format|
      format.json {
        render :json => master_array
      }
    end
  end

  def timeline
    
  end

  def generate_timeline
    @participant.events.delete_all
    @participant.call_log_records.each do |cl|
      CallEvent.create(date: DateTime.strptime((cl.date / 1000).to_s,'%s').in_time_zone("Auckland"), direction: get_type_string(cl.callType), otherParty: (cl.name != nil ? cl.name : cl.number != nil ? cl.number : "Unknown"), participant_id: @participant.id)
    end

    @participant.sms_log_records.each do |cl|
      SmsEvent.create(date: DateTime.strptime((cl.date / 1000).to_s,'%s').in_time_zone("Auckland"), direction: get_sms_string(cl.messageType), otherParty: cl.address, participant_id: @participant.id)
    end

    @participant.location_records.each do |cl|
      LocationUpdateEvent.create(date: DateTime.strptime((cl.date / 1000).to_s,'%s').in_time_zone("Auckland"), description: "#{cl.longitude},#{cl.latitude}",participant_id: @participant.id)
    end

    @participant.messages.each do |m|
      FacebookMessageEvent.create(date: DateTime.strptime((m.date / 1000).to_s,'%s').in_time_zone("Auckland"), direction: m.messageType, otherParty: m.messageType == "incoming"? m.sender : m.facebook_conversation.conversation_participants.count == 1? m.facebook_conversation.conversation_participants.first.name : "Group conversation" , participant_id: @participant.id)
    end

    redirect_to timeline_participant_path(@participant)
  end

  def get_type_string(type)
    if type == 1 
      return "incoming"
    elsif type == 2 
      return "outgoing"
    elsif type == 3 
      return "missed"
    elsif type == 4 
      return "voicemail"
    end
  end

  def get_sms_string(type)
    if type == 1 
      return "incoming"
    elsif type == 2 
      return "outgoing"
    end
  end

  def analysis

  end

  def index

  end

  def summary

  end

  def map
    @date = params[:date]? Date.parse(params[:date]) : DateTime.now.in_time_zone("Auckland").to_date
    
    @locs = @participant.location_records.where('date BETWEEN ? AND ?', @date.in_time_zone("Auckland").beginning_of_day.to_time.to_i * 1000, @date.in_time_zone("Auckland").end_of_day.to_time.to_i * 1000).order(date: :asc)
    @smoothed_locs = get_smooth_location(@locs)
    @hash = Gmaps4rails.build_markers(@smoothed_locs) do |loc, marker|
      marker.lat loc.average_latitude
      marker.lng loc.average_longitude
      # marker.picture({
      #                   :url    => ActionController::Base.helpers.asset_path("gps_orange2.png"),
      #                   :width  => 24,
      #                   :height => 24
      #                 })
      marker.infowindow (loc.count > 1? "#{DateTime.strptime((loc.first.date / 1000).to_s,'%s').in_time_zone("Auckland").strftime('%r')} - #{DateTime.strptime((loc.last.date / 1000).to_s,'%s').in_time_zone("Auckland").strftime('%r')}" : "#{DateTime.strptime((loc.first.date / 1000).to_s,'%s').in_time_zone("Auckland").strftime('%r')}")
    end
    @poly_hash = @hash
    
    @fb_messages = Array.new
    get_facebook_messages.each do |fb|
      earlier = @participant.location_records.where("date <= ? AND accuracy < 200", fb.date).order(date: :asc).limit(1).first
      later = @participant.location_records.where("date >= ? AND accuracy < 200", fb.date).order(date: :desc).limit(1).last
      if earlier == nil and later != nil
        @fb_messages << {data: fb, loc: later}  
      elsif earlier != nil and later == nil
        @fb_messages << {data: fb, loc: earlier}
      elsif later != nil and later != nil
        sel = (fb.date - earlier.date).abs < (later.date - fb.date).abs ? earlier : later
        @fb_messages << {data: fb, loc: sel, to: (fb.facebook_conversation.conversation_participants.count > 1 ? "Group conversation" : fb.facebook_conversation.conversation_participants.first.name)}
      end
      
    end

    @hash = @hash + Gmaps4rails.build_markers(@fb_messages) do |fbm, marker|
      marker.lat fbm[:loc][:latitude]
      marker.lng fbm[:loc][:longitude]
      marker.picture({
                         :url    => (fbm[:data][:messageType] == 'incoming'? ActionController::Base.helpers.asset_path("fb_messengerin.png") : ActionController::Base.helpers.asset_path("fb_messengerout.png")),
                         :width  => 40,
                         :height => 40
                       })
      marker.infowindow (fbm[:data][:messageType] != 'incoming'? "<b>Facebook message to #{fbm[:to]}</b><br>#{DateTime.strptime((fbm[:data][:date] / 1000).to_s,'%s').in_time_zone("Auckland").strftime('%r')}" : "<b>Facebook message from #{fbm[:data][:sender]}</b><br>#{DateTime.strptime((fbm[:data][:date] / 1000).to_s,'%s').in_time_zone("Auckland").strftime('%r')}")
    end

  end

  def get_smooth_location(raw_location_records)
    #need to take list of location records provided and return a "smoothed" list
    #-filter out readings with accuracy of > 200m
    #-combine consecutive locations if distance between them is less than X
    smoothed_location_records = Array.new

    raw_location_records.each do |r|
      if r.accuracy < 200
        if smoothed_location_records.length > 0 and is_close_enough(smoothed_location_records.last, r)
          smoothed_location_records.last.add(r)
        else
          slr = SmoothedLocationRecord.new
          slr.add(r)
          smoothed_location_records << slr
        end
      end
    end
    
    return smoothed_location_records
    
  end

  def get_facebook_messages
    return @participant.messages.where('date BETWEEN ? AND ?', @date.in_time_zone("Auckland").beginning_of_day.to_time.to_i * 1000, @date.in_time_zone("Auckland").end_of_day.to_time.to_i * 1000).order(date: :asc)
  end

  def is_close_enough(slr, lr)
    if (slr.average_latitude - lr.latitude).abs < 0.0008 and (slr.average_longitude - lr.longitude).abs < 0.0008
      return true
    end
    return false
  end


  def data
    max_array = Array.new
    max_array << {:label => 'calls', :value => @participant.call_log_records.count}
    max_array << {:label => 'sms', :value => @participant.sms_log_records.count}
    max_array << {:label => 'location', :value => @participant.location_records.count}
    max_array << {:label => 'apps', :value => @participant.installed_app_records.count}
    max_array << {:label => 'fb_message', :value => @participant.messages.count}
    maxi = 0
    @maxs = ''
    max_array.each do |e|
      if e[:value] > maxi 
        maxi = e[:value]
        @maxs = e[:label]
      end
    end
    
  end

  def get_participant
    @participant = Participant.find(params[:id])
  end

  def destroy

  end


end
