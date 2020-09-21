class CurrentForecast
  def initialize(forecast_data)
    @city = nil
    @state = nil
    @country = nil
    @current_datetime = forecast_data[:current][:dt]
    @current_temp = forecast_data[:current][:temp]
    @current_description = forecast_data[:current][:weather][0][:description]
    @current_feels_like = forecast_data[:current][:feels_like]
    @current_humidity = forecast_data[:current][:humidity]
    @current_visibility = forecast_data[:current][:visibility] # this value is in meters, needs to be changed to miles
    @current_uv_index = forecast_data[:current][:uvi] # does not include the 'low' description displayed in wireframe
    @current_sunrise = forecast_data[:current][:sunrise]
    @current_sunset = forecast_data[:current][:sunset]
    @current_sunset = forecast_data[:current][:sunset]
  end
end
