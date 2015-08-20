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

        when "sms_logs"

        when "contacts"

        when "installed_apps"

        end
      end
      
    end


  end

end
