class DashboardController < ApplicationController

  before_action :authenticate_user!

  def dashboard

  end

  def main
      if Survey.all.count == 0
        redirect_to new_api_survey_path
      end
  end

  def participants
    
  end

end