class RouteService
  def get_route_data(start_params, end_params)
    response = conn.get('directions/v2/route') do |f|
      f.params[:from] = start_params
      f.params[:to] = end_params
    end

    parse_json(response)
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
