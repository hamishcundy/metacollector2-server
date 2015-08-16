class SurveysController < ApplicationController

  def new
    @survey = Survey.new
    @sources = get_source_list
  end

  def create
    Survey.create(params[:survey].permit(:name, :terms, :details_required))
    redirect_to dashboard_path, notice: 'Survey successfully created'
  end

  def edit
    @survey = Survey.first
    @sources = get_source_list
  end

  def update
    @survey = Survey.first
    @survey.collection_sources.delete_all
    if @survey.update(params[:survey].permit(:name, :terms, :details_required, :collection_source_attributes))
      redirect_to dashboard_path, notice: 'Survey successfully updated'
    else
      redirect_to dashboard_path, notice: 'Survey failed to update'
    end
  end

  def get_source_string_list
    return Array['call_logs', 'sms_logs', 'contacts', 'installed_apps']
  end

  def get_source_list
    sources = Array.new
    get_source_string_list.each do |s|
      sources << {:key => s, :available => CollectionSource.where("key = '#{s}'").count > 0, :required => (CollectionSource.where("key = '#{s}'").count > 0) && (CollectionSource.where("key = '#{s}'").first.required)}
    end
    return sources
  end
end

