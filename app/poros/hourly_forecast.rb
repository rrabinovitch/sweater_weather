class HourlyForecast
  attr_reader :datetime, :temp, :summary

  def initialize(hourly_data)
    @datetime = hourly_data[:dt]
    @temp = hourly_data[:temp]
    @summary = hourly_data[:weather][0][:description]
  end

  def self.eight_hr_forecast(hourly_data)
    hourly_data.take(8).map do |one_hr_data|
      HourlyForecast.new(one_hr_data)
    end
  end
end
