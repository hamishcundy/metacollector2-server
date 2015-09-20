class CreateFacebookConversationParticipants < ActiveRecord::Migration
  def change
    create_table :conversation_participants do |t|
      t.references :facebook_conversation, index: true
      t.string :name

      t.timestamps null: false
    end
    add_foreign_key :conversation_participants, :facebook_conversations
  end
end
