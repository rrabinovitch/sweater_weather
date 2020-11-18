class CurrentForecast
  attr_reader :datetime, :temp, :description, :feels_like,
              :humidity, :visibility, :uv_index,
              :sunrise, :sunset

  def initialize(current_data)
    @datetime = current_data[:dt]
    @temp = current_data[:temp].to_f
    @description = current_data[:weather][0][:description]
    @feels_like = current_data[:feels_like].to_f
    @humidity = current_data[:humidity]
    @visibility = current_data[:visibility] # this value is in meters, needs to be changed to miles
    @uv_index = current_data[:uvi].to_f # does not include the 'low' description displayed in wireframe
    @sunrise = current_data[:sunrise]
    @sunset = current_data[:sunset]
  end
end
