class ForecastFacade
  def initialize
    @geo_service ||= GeoService.new
    @weather_service ||= WeatherService.new
  end

  def get_location(location)
    location_data = @geo_service.location_data(location)
    Location.new(location_data)
  end

  def get_forecast(location)
    location = get_location(location)
    forecast_data = @weather_service.forecast_by_coordinates(location.coordinates)

    Forecast.new(forecast_data)

    ### return value should be the big forecast hash that can then be serialized in ForecastsController

    ### COLLECT FORECAST INFO AND THEN ORGANIZE INTO LARGE HASH?

  end
end
