class ChangeTypeToString < ActiveRecord::Migration
  def change
    change_column :events, :type, :string
  end
end
