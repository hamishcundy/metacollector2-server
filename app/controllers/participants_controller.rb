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
    generate_timeline
  end

  def generate_timeline
    @participant.events.delete_all
    @participant.call_log_records.each do |cl|
      CallEvent.create(date: DateTime.strptime((cl.date / 1000).to_s,'%s').in_time_zone("Auckland"), direction: get_type_string(cl.callType), otherParty: (cl.name != nil ? cl.name : 'unknown' ), participant_id: @participant.id)
    end

    @participant.sms_log_records.each do |cl|
      SmsEvent.create(date: DateTime.strptime((cl.date / 1000).to_s,'%s').in_time_zone("Auckland"), direction: get_sms_string(cl.messageType), otherParty: cl.address, participant_id: @participant.id)
    end

    @participant.location_records.each do |cl|
      LocationUpdateEvent.create(date: DateTime.strptime((cl.date / 1000).to_s,'%s').in_time_zone("Auckland"), description: "#{cl.longitude},#{cl.latitude}",participant_id: @participant.id)
    end

    @participant.messages.each do |m|
      FacebookMessageEvent.create(date: DateTime.strptime((m.date / 1000).to_s,'%s').in_time_zone("Auckland"), direction: m.messageType, participant_id: @participant.id)
    end
  end

  def get_type_string(type)
    if type == 1 
      return "Incoming"
    elsif type == 2 
      return "Outgoing"
    elsif type == 3 
      return "Missed"
    elsif type == 4 
      return "Voicemail"
    end
  end

  def get_sms_string(type)
    if type == 1 
      return "Incoming"
    elsif type == 2 
      return "Outgoing"
    end
  end

  def analysis

  end

  def index

  end

  def summary

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
