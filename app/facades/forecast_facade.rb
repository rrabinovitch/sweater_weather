class ForecastFacade
  def self.get_location(location)
    location_data = GeoService.location_data(location)
    Location.new(location_data)
  end

  def self.get_forecast(location)
    location = get_location(location)
    forecast_data = WeatherService.forecast_by_coordinates(location.coordinates)
    Forecast.new(location, forecast_data)
  end
end
