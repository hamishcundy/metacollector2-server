class ParticipantsController < ApplicationController



  before_action :authenticate_user!

  def timeline_data
    master_array = Array.new
    participant = Participant.find(params[:id])


    sms_dates = participant.sms_log_records.pluck(:date)
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


end
