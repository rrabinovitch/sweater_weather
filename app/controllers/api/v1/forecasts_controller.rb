class Api::V1::ForecastsController < ApplicationController
  def show
    location = params[:location]

    geo_conn = Faraday.new(url: 'http://www.mapquestapi.com/') do |f|
      f.params[:key] = ENV['MAPQUEST_API_KEY']
    end

    geo_response = geo_conn.get('geocoding/v1/address/') do |f|
      f.params[:location] = location
    end

    geo_json = JSON.parse(geo_response.body, symbolize_names: true)

    lat_lon = geo_json[:results][0][:locations][0][:latLng]
    lat = lat_lon[:lat]
    lon = lat_lon[:lng]

    weather_conn = Faraday.new(url: 'https://api.openweathermap.org/') do |f|
      f.params[:appid] = ENV['OPEN_WEATHER_API_KEY']
    end

    weather_response = weather_conn.get('data/2.5/onecall') do |f|
      f.params[:lat] = lat
      f.params[:lon] = lon
    end

    weather_json = JSON.parse(weather_response.body, symbolize_names: true)

    render json: weather_json
  end
end
