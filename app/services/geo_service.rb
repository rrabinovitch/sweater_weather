class GeoService
  def location_coordinates
    # geo_conn = Faraday.new(url: 'http://www.mapquestapi.com/') do |f|
    #   f.params[:key] = ENV['MAPQUEST_API_KEY']
    # end
    #
    # geo_response = geo_conn.get('geocoding/v1/address/') do |f|
    #   f.params[:location] = location
    # end
    #
    # geo_json = JSON.parse(geo_response.body, symbolize_names: true)
  end
end
