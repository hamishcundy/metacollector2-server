class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :imei
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end
