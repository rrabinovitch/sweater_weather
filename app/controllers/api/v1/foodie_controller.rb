class Api::V1::FoodieController < ApplicationController
  def show
    start_params = params[:start]
    end_params = params[:end]
    search_params = params[:search]

    # use start and end params as is to get directions and travel time
    route_conn = Faraday.new(url: 'http://www.mapquestapi.com/') do |f|
      f.params[:key] = ENV['MAPQUEST_API_KEY']
    end

    route_response = route_conn.get('directions/v2/route') do |f|
      f.params[:from] = start_params
      f.params[:to] = end_params
    end

    route_json = JSON.parse(route_response.body, symbolize_names: true)

    travel_time = route_json[:route][:legs].first[:time] # in seconds


    # use end params and GeoService to obtain lat/long of end params
    end_location = FORECAST_FACADE.get_location(end_params)
    end_coordinates = end_location.coordinates
    
    binding.pry
    # use lat/long for end params and search params via ZomatoService to obtain restaurant name and address
    # calculate time of arrival??
    # use lat/long for end params and time of arrival/travel time via WeatherService to access forecast at time of arrival
  end

  private

  FORECAST_FACADE ||= ForecastFacade.new
end
