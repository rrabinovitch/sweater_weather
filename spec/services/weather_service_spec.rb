require 'rails_helper'

RSpec.describe WeatherService do
  it 'can return a forecast for a set of coordinates' do
    coordinates = {:lat=>39.738453, :lng=>-104.984853}

    weather_service = WeatherService.new
    results = weather_service.forecast_by_coordinates(coordinates)
    expect(results).to be_a(Hash)
    expect(results).to have_key(:current)
    expect(results).to have_key(:hourly)
    expect(results).to have_key(:daily)
  end
end
