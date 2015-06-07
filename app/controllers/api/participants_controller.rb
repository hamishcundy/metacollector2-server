module Api
  class ParticipantsController < ApplicationController

    def test
      respond_to do |format|
        
        format.any { render json: 'test'}
      end
    end
  end

end
