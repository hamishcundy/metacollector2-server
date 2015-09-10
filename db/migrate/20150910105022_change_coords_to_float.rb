class ChangeCoordsToFloat < ActiveRecord::Migration
  def change
    change_column :location_records, :latitude, :float
    change_column :location_records, :longitude, :float
  end
end
