class GeoService
  def self.location_data(location)
    response = conn.get('geocoding/v1/address/') do |f|
      f.params[:location] = location
      f.params[:maxResults] = 1
    end

    parse_json(response)[:results][0][:locations][0]
  end

  private

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com/') do |f|
      f.params[:key] = ENV['MAPQUEST_API_KEY']
    end
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
