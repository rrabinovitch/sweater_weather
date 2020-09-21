class CurrentForecast
  attr_reader :datetime, :temp, :description, :feels_like,
              :humidity, :visibility, :uv_index,
              :sunrise, :sunset
              
  def initialize(forecast_data)
    ## these should probably go elsewhere
    # @city = nil
    # @state = nil
    # @country = nil
    @datetime = forecast_data[:current][:dt]
    @temp = forecast_data[:current][:temp]
    @description = forecast_data[:current][:weather][0][:description]
    @feels_like = forecast_data[:current][:feels_like]
    @humidity = forecast_data[:current][:humidity]
    @visibility = forecast_data[:current][:visibility] # this value is in meters, needs to be changed to miles
    @uv_index = forecast_data[:current][:uvi] # does not include the 'low' description displayed in wireframe
    @sunrise = forecast_data[:current][:sunrise]
    @sunset = forecast_data[:current][:sunset]
  end
end
