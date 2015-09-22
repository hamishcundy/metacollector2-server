module Api
  class DataController < ApplicationController

    skip_before_filter  :verify_authenticity_token #since its an api controller, dont need csrf protection


    def upload
      #logger.debug params
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

        when "facebook_data"
          @participant.conversations.destroy_all
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

        when "facebook_data"
          if p[0] == "name"

          elsif p[0] == "conversations"
            p[1].each do |con|
              logger.debug con
              @participant.conversations.create(con.permit!)
            end
            
          end
          
          #@participant.conversations.create(p["conversations"].permit!)
        end
      end

      render json: nil
      
    end

    def location
      @participant = Participant.find(params[:participantId])
      @participant.location_records.create(params[:location].permit(:longitude, :latitude, :accuracy, :source, :date))
      render json: nil
    end


  end

end
