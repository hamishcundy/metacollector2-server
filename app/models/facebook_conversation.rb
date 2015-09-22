class FacebookConversation < ActiveRecord::Base
  belongs_to :participant
  has_many :conversation_participants, dependent: :destroy
  has_many :facebook_messages, dependent: :destroy
  has_many :messages, foreign_key: "facebook_conversation_id", class_name: "FacebookMessage"
  accepts_nested_attributes_for :messages
  accepts_nested_attributes_for :conversation_participants
end
