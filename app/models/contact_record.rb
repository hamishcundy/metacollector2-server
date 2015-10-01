class ContactRecord < ActiveRecord::Base
  belongs_to :participant
  has_many :contact_data_records, dependent: :destroy
  accepts_nested_attributes_for :contact_data_records
end
