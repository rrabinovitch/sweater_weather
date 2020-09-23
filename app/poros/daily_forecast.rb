class DailyForecast
  attr_reader :datetime, :description, :precipitation, :high_temp, :low_temp

  def initialize(daily_data)
    @datetime = daily_data[:dt]
    @description = daily_data[:weather][0][:description]
    @precipitation = total_precipitation(daily_data)
    @high_temp = daily_data[:temp][:max]
    @low_temp = daily_data[:temp][:min]
  end

  def self.five_day_forecast(daily_data)
    daily_data.take(5).map do |one_day_data|
      DailyForecast.new(one_day_data)
    end
  end

  private

  def total_precipitation(daily_data)
    if daily_data[:rain].nil? && daily_data[:snow].nil?
      @precipitation = 0.0
    elsif daily_data[:rain].nil? && !daily_data[:snow].nil?
      @precipitation = daily_data[:snow].to_f
    elsif !daily_data[:rain].nil? && daily_data[:snow].nil?
      @precipitation = daily_data[:rain].to_f
    else
      @precipitation = daily_data[:rain] + daily_data[:snow].to_f
    end
  end
end
