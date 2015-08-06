class SurveysController < ApplicationController

  def new
    @survey = Survey.new
  end

  def create
    Survey.create(params[:survey].permit!)
    redirect_to dashboard_path
  end

  def edit
    @survey = Survey.first
  end

  def update

  end
end
