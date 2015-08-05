module Api
  class ParticipantsController < ApplicationController

    





    def create
      @p = Participant.create(params.permit(:name, :email, :imei))
      render json: @p.id
    end
  end

end
