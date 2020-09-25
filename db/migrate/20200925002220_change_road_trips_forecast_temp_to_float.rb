class ChangeRoadTripsForecastTempToFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :road_trips, :forecast_temp, :float
  end
end
