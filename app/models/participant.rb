class Participant < ActiveRecord::Base
  has_many :call_logs_records
  has_many :sms_log_records
  has_many :installed_app_records
end
