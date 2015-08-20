class CreateInstalledAppRecords < ActiveRecord::Migration
  def change
    create_table :installed_app_records do |t|
      t.string :packageName
      t.string :appName
      t.references :participant, index: true

      t.timestamps null: false
    end
    add_foreign_key :installed_app_records, :participants
  end
end
