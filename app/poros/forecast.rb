class Forecast
  attr_reader :id, :location, :current, :hourly, :daily

  def initialize(location, forecast_data)
    @id = nil
    @location = location
    @current = CurrentForecast.new(forecast_data[:current])
    @hourly = HourlyForecast.eight_hr_forecast(forecast_data[:hourly])
    @daily = DailyForecast.five_day_forecast(forecast_data[:daily])
  end
end
