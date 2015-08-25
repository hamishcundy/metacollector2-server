class SurveysController < ApplicationController

  def new
    @survey = Survey.new
    @sources = get_source_list
  end

  def create
    
    survey_params = params[:survey].permit(:name, :terms, :details_required, :collection_sources_attributes => [:survey_id, :key, :required, :available])
    collection_params = survey_params.delete("collection_sources_attributes")
    @survey = Survey.create(survey_params)
    collection_params.each do |p|
      
      if p["available"]
        
        p.delete("available")
        @survey.collection_sources.create(p)
      end
    end
    
    redirect_to dashboard_path, notice: 'Survey successfully updated'
    
  end

  def edit
    @survey = Survey.first
    @sources = get_source_list
  end

  def update
    @survey = Survey.first
    survey_params = params[:survey].permit(:name, :terms, :details_required, :collection_sources_attributes => [:survey_id, :key, :required, :available])
    collection_params = survey_params.delete("collection_sources_attributes")
    @survey.collection_sources.destroy_all
    collection_params.each do |p|
      logger.debug p
      if p["available"]
        logger.debug "saving"
        p.delete("available")
        @survey.collection_sources.create(p)
      end
    end
    if @survey.update(survey_params)
      redirect_to dashboard_path, notice: 'Survey successfully updated'
    else
      redirect_to dashboard_path, notice: 'Survey failed to update'
    end
  end

  def get_source_string_list
    return Array['call_logs', 'sms_logs', 'contacts', 'installed_apps', 'facebook_data']
  end

  def get_source_list
    sources = Array.new
    get_source_string_list.each do |s|
      sources << {:key => s, :available => CollectionSource.where("key = '#{s}'").count > 0, :required => (CollectionSource.where("key = '#{s}'").count > 0) && (CollectionSource.where("key = '#{s}'").first.required)}
    end
    return sources
  end
end

