require 'rails_helper'

RSpec.describe Forecast do
  it 'has attributes' do
    VCR.use_cassette('Denver forecast') do
      location_data = {:adminArea5=>"Denver",
        :adminArea3=>"CO",
        :adminArea1=>"US",
        :latLng=>{:lat=>39.738453, :lng=>-104.984853}}

        location = Location.new(location_data)

        forecast_data = WeatherService.forecast_by_coordinates(location.coordinates)

        forecast = Forecast.new(location, forecast_data)

        expect(forecast).to be_a(Forecast)
        expect(forecast.id).to eq(nil)
        expect(forecast.location).to be_a(Location)
        expect(forecast.current).to be_a(CurrentForecast)
        expect(forecast.hourly.size).to eq(8)
        expect(forecast.hourly.first).to be_an(HourlyForecast)
        expect(forecast.daily.size).to eq(5)
        expect(forecast.daily.first).to be_a(DailyForecast)
    end
  end
end
