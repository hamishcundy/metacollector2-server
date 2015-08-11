class CreateCollectionSources < ActiveRecord::Migration
  def change
    create_table :collection_sources do |t|
      t.string :key

      t.timestamps null: false
    end
    add_index :collection_sources, :key, unique: true
  end
end
