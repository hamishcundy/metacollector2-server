class RemovedIndexesFromCollectionSource < ActiveRecord::Migration
  def change
    remove_index :collection_sources, :key
    remove_index :collection_sources, :survey_id
  end
end
