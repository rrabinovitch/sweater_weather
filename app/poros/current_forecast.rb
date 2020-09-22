class CurrentForecast
  attr_reader :datetime, :temp, :description, :feels_like,
              :humidity, :visibility, :uv_index,
              :sunrise, :sunset

  def initialize(current_forecast_data)
    @datetime = current_forecast_data[:dt]
    @temp = current_forecast_data[:temp]
    @description = current_forecast_data[:weather][0][:description]
    @feels_like = current_forecast_data[:feels_like]
    @humidity = current_forecast_data[:humidity]
    @visibility = current_forecast_data[:visibility] # this value is in meters, needs to be changed to miles
    @uv_index = current_forecast_data[:uvi] # does not include the 'low' description displayed in wireframe
    @sunrise = current_forecast_data[:sunrise]
    @sunset = current_forecast_data[:sunset]
  end
end
