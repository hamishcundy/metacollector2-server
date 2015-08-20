module Api
  class DataController < ApplicationController

    skip_before_filter  :verify_authenticity_token #since its an api controller, dont need csrf protection


    def upload
      logger.debug params
      @participant = Participant.find(params[:participantId])
      @key = params[:source]
      params[:payload].each do|p|
        case @key
        when "call_logs"
          CallLogRecord.create(p.permit!)
        when "sms_logs"
          SMSLogRecord.create(p.permit!)
        when "contacts"

        when "installed_apps"
          InstalledAppRecord.create(p.permit!)
        end
      end

      render json: nil
      
    end


  end

end
