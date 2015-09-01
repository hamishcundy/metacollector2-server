module Api
  class DataController < ApplicationController

    skip_before_filter  :verify_authenticity_token #since its an api controller, dont need csrf protection


    def upload
      logger.debug params
      @participant = Participant.find(params[:participantId])
      @key = params[:source]

      #clear all existing records of this type for this participant
      case @key
        when "call_logs"
          @participant.call_log_records.destroy_all
        when "sms_logs"
          @participant.sms_log_records.destroy_all
        when "contacts"

        when "installed_apps"
          @participant.installed_app_records.destroy_all
        end

      #add each record  
      params[:payload].each do|p|
        case @key
        when "call_logs"
          @participant.call_log_records.create(p.permit!)
        when "sms_logs"
          @participant.sms_log_records.create(p.permit!)
        when "contacts"

        when "installed_apps"
          @participant.installed_app_records.create(p.permit!)
        end
      end

      render json: nil
      
    end


  end

end
