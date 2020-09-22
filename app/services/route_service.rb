class RouteService
  def get_route_data(start_params, end_params)
    route_conn = Faraday.new(url: 'http://www.mapquestapi.com/') do |f|
      f.params[:key] = ENV['MAPQUEST_API_KEY']
    end

    route_response = route_conn.get('directions/v2/route') do |f|
      f.params[:from] = start_params
      f.params[:to] = end_params
    end

    route_json = JSON.parse(route_response.body, symbolize_names: true)
  end
end
