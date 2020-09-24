class RoadTripFacade
  def self.get_road_trip(origin, destination, user)
    directions_data = MapQuestService.directions_data(origin, destination)
    travel_time_hr = ( directions_data[:time].to_f / 360 )

    destination_coordinates = MapQuestService.location_data(destination)[:latLng]

    forecast_data = WeatherService.forecast_by_coordinates(destination_coordinates)

    arrival_forecast = assemble_arrival_forecast(forecast_data[:hourly][travel_time_hr.round - 1])

    create_road_trip_for_user(origin, destination, travel_time_hr, arrival_forecast, user)
  end

  def self.create_road_trip_for_user(origin, destination, travel_time, forecast, user)
    user.road_trips.create(origin: origin, destination: destination, travel_time: travel_time,
      forecast_temp: forecast[:temp], forecast_description: forecast[:description])
  end

  def self.assemble_arrival_forecast(arrival_forecast_data)
    {
      temp: arrival_forecast_data[:temp],
      description: arrival_forecast_data[:weather][0][:description]
    }
  end
end
