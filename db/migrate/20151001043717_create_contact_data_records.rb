class CreateContactDataRecords < ActiveRecord::Migration
  def change
    create_table :contact_data_records do |t|
      t.references :contact_record, index: true
      t.string :dataType
      t.string :subType
      t.string :data

      t.timestamps null: false
    end
    add_foreign_key :contact_data_records, :contact_records
  end
end
