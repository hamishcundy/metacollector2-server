class CreateFacebookMessages < ActiveRecord::Migration
  def change
    create_table :facebook_messages do |t|
      t.references :facebook_conversation, index: true
      t.string :sender
      t.bigint :date
      t.string :type

      t.timestamps null: false
    end
    add_foreign_key :facebook_messages, :facebook_conversations
  end
end
