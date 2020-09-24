class RoadTrip < ApplicationRecord
  validates_presence_of :origin, :destination, :travel_time, :forecast_temp, :forecast_description, :user_id
  belongs_to :user
end
