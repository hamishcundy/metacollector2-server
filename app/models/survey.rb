class Survey < ActiveRecord::Base

  has_attached_file :apk
  validates_attachment_content_type :apk, :content_type => ["application/octet-stream"]
  validates_attachment_file_name :apk, :matches => [/apk\Z/]
end
