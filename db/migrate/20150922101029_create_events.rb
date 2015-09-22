class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :type
      t.string :direction
      t.string :otherParty
      t.string :description

      t.timestamps null: false
    end
  end
end
