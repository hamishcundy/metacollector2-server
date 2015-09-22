class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :facebook_messages, :type, :messageType
  end
end
