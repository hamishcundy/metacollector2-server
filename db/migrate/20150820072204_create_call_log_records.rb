class CreateCallLogRecords < ActiveRecord::Migration
  def change
    create_table :call_log_records do |t|
      t.string :formattedNumber
      t.integer :numberType
      t.integer :duration
      t.integer :presentation
      t.integer :type
      t.string :number
      t.bigint :date
      t.string :numberLabel
      t.string :name
      t.string :matchedNumber
      t.string :normalizedNumber
      t.references :participant, index: true

      t.timestamps null: false
    end
    add_foreign_key :call_log_records, :participants
  end
end
