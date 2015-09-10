class ChangeCoordsToDecimal < ActiveRecord::Migration
  def change
    change_column :location_records, :latitude, :decimal
    change_column :location_records, :longitude, :decimal
  end
end
