require 'rails_helper'

RSpec.describe ForecastFacade do
  it '::get_location' do
    VCR.use_cassette('Encino geolocation') do
      location = ForecastFacade.get_location('Encino, CA')
      expect(location).to be_a(Location)
    end
  end

  it '::get_forecast' do
    VCR.use_cassette('Denver forecast') do
      forecast = ForecastFacade.get_forecast('denver,co')
      expect(forecast).to be_a(Forecast)
      expect(forecast.location).to be_a(Location)
      expect(forecast.current).to be_a(CurrentForecast)
      expect(forecast.daily.first).to be_a(DailyForecast)
      expect(forecast.hourly.first).to be_a(HourlyForecast)
    end
  end
end
