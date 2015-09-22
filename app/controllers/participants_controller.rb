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
