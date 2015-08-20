module Api
  class DataController < ApplicationController

    def upload
      
      @participant = Participant.find(params[:participantId])
      @key = params[:source]
      case @key
      when "call_logs"

      when "sms_logs"

      when "contacts"

      when "installed_apps"
        
      end
      
    end


  end

end
