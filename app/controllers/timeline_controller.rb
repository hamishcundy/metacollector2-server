class TimelineController < ApplicationController

  before_action :authenticate_user!

  def timeline_data
    participant = Participant.first
    dates = participant.sms_log_records.pluck(:date)
    logger.debug dates
    respond_to do |format|
      format.json {
        render :json => [1,2,3,4,5]
      }
    end
  end

  def index

  end

end