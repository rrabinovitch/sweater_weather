class FoodieFacade
  def initialize
    @route_service ||= RouteService.new
    @geo_service ||= GeoService.new
    @zomato_service ||= ZomatoService.new
    @weather_service ||= WeatherService.new
  end

  def method_name

  end
end
