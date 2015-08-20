class CreateSmsLogRecords < ActiveRecord::Migration
  def change
    create_table :sms_log_records do |t|
      t.integer :threadId
      t.string :address
      t.integer :person
      t.bigint :date
      t.bigint :dateSent
      t.integer :type
      t.references :participant, index: true

      t.timestamps null: false
    end
    add_foreign_key :sms_log_records, :participants
  end
end
