class FoodieFacade
  def initialize
    @route_service ||= RouteService.new
    @geo_service ||= GeoService.new
    # @zomato_service ||= ZomatoService.new
    # @weather_service ||= WeatherService.new
  end

  def get_foodie_route_info(start_params, end_params, search_params)

  end

  def get_travel_time_in_hrs(start_params, end_params)
    route_data = @route_service.get_route_data(start_params, end_params)
    travel_time_sec = route_data[:route][:legs][0][:time]
    (travel_time_sec / 60 / 60)
  end


end
