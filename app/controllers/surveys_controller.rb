class SurveysController < ApplicationController

  def new
    @survey = Survey.new
  end

  def create
    Survey.create(params[:survey].permit!)
    redirect_to dashboard_path, notice: 'Survey successfully created'
  end

  def edit
    @survey = Survey.first
  end

  def update
    @survey = Survey.first
    if @survey.update(params[:survey].permit!) do
      redirect_to dashboard_path, notice: 'Survey successfully updated'
    else
      redirect_to dashboard_path, notice: 'Survey failed to update'
    end
  end
end

