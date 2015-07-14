module Api
  class SurveyController < ApplicationController

    def survey_details
      respond_to do |format|
        
        format.any { render json: 'test'}
      end
    end

    def new


    end

    def create

    end
  end

end
