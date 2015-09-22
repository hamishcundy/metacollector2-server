class Participant < ActiveRecord::Base
  has_many :call_log_records
  has_many :sms_log_records
  has_many :installed_app_records
  has_many :location_records
  has_many :conversations, foreign_key: "participant_id", class_name: "FacebookConversation"
end
