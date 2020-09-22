class CurrentForecast
  attr_reader :datetime, :temp, :description, :feels_like,
              :humidity, :visibility, :uv_index,
              :sunrise, :sunset

  def initialize(forecast_data)
    @datetime = forecast_data[:dt]
    @temp = forecast_data[:temp]
    @description = forecast_data[:weather][0][:description]
    @feels_like = forecast_data[:feels_like]
    @humidity = forecast_data[:humidity]
    @visibility = forecast_data[:visibility] # this value is in meters, needs to be changed to miles
    @uv_index = forecast_data[:uvi] # does not include the 'low' description displayed in wireframe
    @sunrise = forecast_data[:sunrise]
    @sunset = forecast_data[:sunset]
  end
end
