class Participant < ActiveRecord::Base
  has_many :call_log_records, dependent: :destroy
  has_many :sms_log_records, dependent: :destroy
  has_many :installed_app_records, dependent: :destroy
  has_many :location_records, dependent: :destroy
  has_many :conversations, foreign_key: "participant_id", class_name: "FacebookConversation", dependent: :destroy
  has_many :messages, through: :conversations
  has_many :events, dependent: :destroy
  has_many :contact_records, dependent: :destroy
end
