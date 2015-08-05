module Api
  class ParticipantsController < ApplicationController

    





    def create
      @p = Participant.create(params)
      render json: @p.id
    end
  end

end
