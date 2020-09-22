class Location
  attr_reader :coordinates, :city, :state, :country

  def initialize(location_data)
    @coordinates = location_data[:latLng]
    @city = location_data[:adminArea5]
    @state = location_data[:adminArea3]
    @country = location_data[:adminArea1]
  end
end
