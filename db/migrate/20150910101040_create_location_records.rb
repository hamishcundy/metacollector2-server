class CreateLocationRecords < ActiveRecord::Migration
  def change
    create_table :location_records do |t|
      t.references :participant, index: true
      t.integer :latitude
      t.integer :longitude
      t.float :accuracy
      t.bigint :date

      t.timestamps null: false
    end
    add_foreign_key :location_records, :participants
  end
end
