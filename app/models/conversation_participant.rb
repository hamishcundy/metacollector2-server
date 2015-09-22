class ConversationParticipant < ActiveRecord::Base
  belongs_to :facebook_conversation
end
