class DashboardController < ApplicationController

  def dashboard

  end

  def main
      if Survey.all.count == 0
        redirect_to new_api_survey_path
      else
        redirect_to :dashboard
      end
  end

end