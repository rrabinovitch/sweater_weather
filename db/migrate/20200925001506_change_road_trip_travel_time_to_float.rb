class ChangeRoadTripTravelTimeToFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :road_trips, :travel_time, :float
  end
end
