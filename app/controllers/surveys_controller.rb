class SurveysController < ApplicationController

  def new

  end

  def create
    Survey.create(params[:survey].permit!)
    redirect_to dashboard_path
  end

  def edit

  end

  def update

  end
end
