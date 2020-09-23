require 'rails_helper'

RSpec.describe ForecastFacade do
  before :each do
    @forecast_facade = ForecastFacade.new
  end

  it '#get_location' do
    location = @forecast_facade.get_location('Encino, CA')
    expect(location).to be_a(Location)
  end

  it '#get_forecast' do
    forecast = @forecast_facade.get_forecast('Encino, CA')
    expect(forecast).to be_a(Forecast)
    expect(forecast.location).to be_a(Location)
    expect(forecast.current).to be_a(CurrentForecast)
    expect(forecast.daily.first).to be_a(DailyForecast)
    expect(forecast.hourly.first).to be_a(HourlyForecast)
  end
end
