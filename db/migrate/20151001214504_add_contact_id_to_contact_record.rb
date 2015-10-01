class AddContactIdToContactRecord < ActiveRecord::Migration
  def change
    add_column :contact_records, :contactId, :integer
  end
end
