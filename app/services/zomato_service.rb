class ZomatoService
  def get_restaurant_data(end_coordinates, search_params)
    response = conn.get('api/v2.1/search') do |f|
      f.params[:q] = search_params
      f.params[:count] = 1
      f.params[:lat] = end_coordinates[:lat]
      f.params[:lon] = end_coordinates[:lng]
    end

    parse_json(response)
  end

  private

  def conn
    Faraday.new(url: 'https://developers.zomato.com/') do |f|
      f.headers["user-key"] = ENV['ZOMATO_API_KEY']
    end
  end

  def parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
