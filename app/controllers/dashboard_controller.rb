class DashboardController < ApplicationController

  before_action :authenticate_user!

  

  def main
      if Survey.all.count == 0
        redirect_to new_survey_path
      end
  end

  def participants
    
  end

  

end