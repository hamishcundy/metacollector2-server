class CreateFacebookConversations < ActiveRecord::Migration
  def change
    create_table :facebook_conversations do |t|
      t.references :participant, index: true

      t.timestamps null: false
    end
    add_foreign_key :facebook_conversations, :participants
  end
end
