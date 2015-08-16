module Api
  class SurveyController < ApplicationController

    def survey_details
      render json: Survey.first.as_json(:only => [:name, :terms, :details_required], :include=> {:collection_sources => {only:[:key, :required]}})
      
    end

    
  end

end
