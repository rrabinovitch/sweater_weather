class HourlyForecast

  def initialize(forecast_data)
    @time = forecast_data[:dt]
    @temp = forecast_data[:temp]
  end

  def self.eight_hr_forecast(forecast_data)
    forecast_data.take(8).map do |hr_data|
      HourlyForecast.new(hr_data)
    end
  end
end
