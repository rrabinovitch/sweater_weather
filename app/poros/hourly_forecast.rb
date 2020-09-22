class HourlyForecast
  attr_reader :time, :temp

  def initialize(hourly_data)
    @time = hourly_data[:dt]
    @temp = hourly_data[:temp]
  end

  def self.eight_hr_forecast(hourly_data)
    hourly_data.take(8).map do |one_hr_data|
      HourlyForecast.new(one_hr_data)
    end
  end
end
