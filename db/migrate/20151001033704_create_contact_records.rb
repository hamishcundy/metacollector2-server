class CreateContactRecords < ActiveRecord::Migration
  def change
    create_table :contact_records do |t|
      t.references :participant, index: true
      t.string :displayName
      t.bigint :lastTimeContacted
      t.integer :timesContacted

      t.timestamps null: false
    end
    add_foreign_key :contact_records, :participants
  end
end
