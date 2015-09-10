class AddSourceToLocationRecord < ActiveRecord::Migration
  def change
    add_column :location_records, :source, :string
  end
end
