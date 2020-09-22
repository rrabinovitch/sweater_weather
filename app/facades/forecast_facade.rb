class ForecastFacade
  def initialize
    @geo_service ||= GeoService.new
    @weather_service ||= WeatherService.new
  end

  def self.get_forecast(location)
    coordinates = @geo_service.location_coordinates(location)
    ### return value should be coordinates to then pass as args for forecast retrieval method

    # coordinates = geo_json[:results][0][:locations][0][:latLng]
    # lat = coordinates[:lat]
    # lon = coordinates[:lng]

    @weather_service.forecast_by_coordinates(coordinates)
    ### return value should be the big forecast hash that can then be serialized in ForecastsController
    # weather_conn = Faraday.new(url: 'https://api.openweathermap.org/') do |f|
    #   f.params[:appid] = ENV['OPEN_WEATHER_API_KEY']
    # end
    #
    # weather_response = weather_conn.get('data/2.5/onecall') do |f|
    #   f.params[:lat] = lat
    #   f.params[:lon] = lon
    #   f.params[:exclude] = 'minutely,alerts'
    #   f.params[:units] = 'imperial'
    # end
    #
    # forecast_data = JSON.parse(weather_response.body, symbolize_names: true)
  end
end
