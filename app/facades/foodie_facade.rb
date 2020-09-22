class FoodieFacade
  def initialize
    @route_service ||= RouteService.new
    @geo_service ||= GeoService.new
    @zomato_service ||= ZomatoService.new
    @weather_service ||= WeatherService.new
  end

  def get_travel_time(start_params, end_params)
    route_data = @route_service.get_route_data(start_params, end_params)

  end
end
