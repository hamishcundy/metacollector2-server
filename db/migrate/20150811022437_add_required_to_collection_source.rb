class AddRequiredToCollectionSource < ActiveRecord::Migration
  def change
    add_column :collection_sources, :required, :boolean
  end
end
