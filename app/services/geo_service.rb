class GeoService
  def location_data(location)
    response = conn.get('geocoding/v1/address/') do |f|
      f.params[:location] = location
    end
  end

  private

  def conn
    Faraday.new(url: 'http://www.mapquestapi.com/') do |f|
      f.params[:key] = ENV['MAPQUEST_API_KEY']
    end
  end

  def parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
