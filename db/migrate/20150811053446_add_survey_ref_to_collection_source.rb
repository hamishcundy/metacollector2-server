class AddSurveyRefToCollectionSource < ActiveRecord::Migration
  def change
    add_reference :collection_sources, :survey, index: true
    add_foreign_key :collection_sources, :surveys
  end
end
