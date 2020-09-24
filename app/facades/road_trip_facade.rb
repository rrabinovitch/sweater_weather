class RoadTripFacade
  def self.get_road_trip(origin, destination, user)
    directions_data = MapQuestService.directions_data(origin, destination)
    travel_time_sec = directions_data[:time]
    travel_time_min = (travel_time_sec.to_f / 60)
    travel_time_hr = (travel_time_min.to_f / 60)
    destination_coordinates = MapQuestService.location_data(destination)[:latLng]

    forecast_data = WeatherService.forecast_by_coordinates(destination_coordinates)

    arrival_forecast = forecast_data[:hourly][travel_time_hr.round - 1]
    arrival_temp = arrival_forecast[:temp]
    arrival_description = arrival_forecast[:weather][0][:description]
    user.road_trips.create(origin: origin, destination: destination, travel_time: travel_time_hr,
      forecast_temp: arrival_temp, forecast_description: arrival_description)
  end
end
