class Forecast
  attr_reader :current, :hourly, :daily

  def initialize(forecast_data)
    @current = CurrentForecast.new(forecast_data[:current])
    @hourly = HourlyForecast.eight_hr_forecast(forecast_data[:hourly])
    @daily = DailyForecast.five_day_forecast(forecast_data[:daily])
  end
end
