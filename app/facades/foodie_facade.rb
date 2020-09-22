class FoodieFacade
  def initialize
    @route_service ||= RouteService.new
    @geo_service ||= GeoService.new
    @zomato_service ||= ZomatoService.new
    @weather_service ||= WeatherService.new
  end

  def get_foodie_route_info(start_params, end_params, search_params)
    travel_time_in_hrs = get_travel_time_in_hrs(start_params, end_params)
    end_location = get_end_location(end_params)
    end_coordinates = end_location.coordinates
    restaurant = get_restaurant(end_coordinates, search_params)
    toa_forecast = get_toa_forecast(end_coordinates, travel_time_in_hrs)

    response = {
      "data": {
        "id": "null",
        "type": "foodie",
        "attributes": {
          "end_location": {
            "city": end_location.city,
            "state": end_location.state
          },
          "travel_time": "approximately #{travel_time_in_hrs} hour(s)",
          "forecast": {
            "summary": toa_forecast.summary,
            "temperature": toa_forecast.temp
          },
          "restaurant": {
            "name": restaurant.name,
            "address": restaurant.address
          }
        }
      }
    }
  end

  def get_travel_time_in_hrs(start_params, end_params)
    route_data = @route_service.get_route_data(start_params, end_params)
    travel_time_sec = route_data[:route][:legs][0][:time]
    (travel_time_sec / 60 / 60)
  end

  def get_end_location(end_params)
    location_data = @geo_service.location_data(end_params)
    Location.new(location_data)
  end

  def get_restaurant(end_coordinates, search_params)
    restaurant_data = @zomato_service.get_restaurant_data(end_coordinates, search_params)
    Restaurant.new(restaurant_data)
  end

  def get_toa_forecast(end_coordinates, travel_time_in_hrs) # toa = time of arrival
    forecast_data = @weather_service.forecast_by_coordinates(end_coordinates)[:hourly][travel_time_in_hrs - 1]
    HourlyForecast.new(forecast_data)
  end
end
