module Api
  class ParticipantsController < ApplicationController

    skip_before_filter  :verify_authenticity_token #since its an api controller, dont need csrf protection

    





    def create
      @p = Participant.create(params.permit(:name, :email, :imei))
      render json: @p.id
    end
  end

end
