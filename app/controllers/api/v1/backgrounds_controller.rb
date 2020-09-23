class Api::V1::BackgroundsController < ApplicationController
  def show
    location = params[:location]

    conn = Faraday.new(url: 'https://api.pexels.com/') do |f|
      f.headers['Authorization'] = ENV['PEXELS_API_KEY']
    end

    response = conn.get('v1/search') do |f|
      f.params[:query] = location
      f.params[:per_page] = 1
    end

    img_json = JSON.parse(response.body, symbolize_names: true)

    render json: img_json
  end
end
