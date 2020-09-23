class PexelService
  def img_by_location(location)
    response = conn.get('v1/search') do |f|
      f.params[:query] = location
      f.params[:per_page] = 1
    end

    parse_json(response)[:photos][0]
  end

  private

  def conn
    Faraday.new(url: 'https://api.pexels.com/') do |f|
      f.headers['Authorization'] = ENV['PEXELS_API_KEY']
    end
  end

  def parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
