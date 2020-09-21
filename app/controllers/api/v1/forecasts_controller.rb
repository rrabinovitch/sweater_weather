class Api::V1::ForecastsController < ApplicationController
  def show
    location = params[:location]

    geo_conn = Faraday.new(url: 'http://www.mapquestapi.com/') do |f|
      f.params[:key] = ENV['MAPQUEST-API-KEY']
    end

    geo_response = conn.get('geocoding/v1/address/') do |f|
      f.params[:location] = location
    end

    geo_json = JSON.parse(response.body, symbolize_names: true)
    lat_long = json[:results][0][:locations][0][:latLng]

    

    binding.pry
  end
end
