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
    @date = DateTime.now
    @locs = @participant.location_records.where('date BETWEEN ? AND ?', @date.in_time_zone("Auckland").beginning_of_day.to_time.to_i * 1000, @date.in_time_zone("Auckland").end_of_day.to_time.to_i * 1000)
    @hash = Gmaps4rails.build_markers(@locs) do |loc, marker|
      marker.lat loc.latitude.round(4)
      marker.lng loc.longitude.round(4)
      #marker.marker_title "Test"
      marker.infowindow "#{DateTime.strptime((loc.date / 1000).to_s,'%s').in_time_zone("Auckland").strftime('%r')} <br/>Accuracy: #{loc.accuracy.to_i}m"
    end

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
