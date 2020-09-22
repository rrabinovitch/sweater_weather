class FoodieFacade
  def initialize
    @route_service ||= RouteService.new
    @geo_service ||= GeoService.new
    @zomato_service ||= ZomatoService.new
    # @weather_service ||= WeatherService.new
  end

  def get_foodie_route_info(start_params, end_params, search_params)
    travel_time_in_hrs = get_travel_time_in_hrs(start_params, end_params)
    end_location = get_end_location(end_params)
    end_coordinates = end_location.coordinates
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

  def get_restaurant_info(end_coordinates, search_params)
    restaurant_data = @zomato_service.restaurant_data(end_coordinates, search_params)
  end
end
