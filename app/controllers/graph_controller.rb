class GraphController < ApplicationController

  before_action :authenticate_user!

  def index

  end

  def timeline_data
    participant = Participant.first
    respond_to do |format|
      format.json {
        render :json => [1,2,3,4,5]
      }
    end
  end
end
