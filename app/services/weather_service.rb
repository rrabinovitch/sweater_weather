class WeatherService
  def forecast_by_coordinates(coordinates)
    response = conn.get('data/2.5/onecall') do |f|
      f.params[:lat] = coordinates[:lat]
      f.params[:lon] = coordinates[:lng]
      f.params[:exclude] = 'minutely,alerts'
      f.params[:units] = 'imperial'
    end

    parse_json(response)
  end

  private

  def conn
    Faraday.new(url: 'https://api.openweathermap.org/') do |f|
      f.params[:appid] = ENV['OPEN_WEATHER_API_KEY']
    end
  end

  def parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
