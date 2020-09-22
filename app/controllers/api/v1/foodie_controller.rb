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

    travel_time_sec = route_json[:route][:legs].first[:time] # in seconds
    travel_time_min = (travel_time_sec / 60) # in minutes (may not need)
    travel_time_hr = (travel_time_min / 60)

    # use end params and GeoService to obtain lat/long of end params
    end_location = FORECAST_FACADE.get_location(end_params)
    end_coordinates = end_location.coordinates

    # use lat/long for end params and search params via ZomatoService to obtain restaurant name and address
    zomato_conn = Faraday.new(url: 'https://developers.zomato.com/') do |f|
      f.headers["user-key"] = ENV['ZOMATO_API_KEY']
    end

    zomato_response = zomato_conn.get('api/v2.1/search') do |f|
      f.params[:q] = search_params
      f.params[:count] = 1
      f.params[:lat] = end_coordinates[:lat]
      f.params[:lon] = end_coordinates[:lng]
    end

    zomato_json = JSON.parse(zomato_response.body, symbolize_names: true)

    restaurant_name = zomato_json[:restaurants].first[:restaurant][:name]
    restaurant_address = zomato_json[:restaurants].first[:restaurant][:location][:address]


    # use lat/long for end params and time of arrival/travel time via WeatherService to access forecast at time of arrival
    end_forecast = WEATHER_SERVICE.forecast_by_coordinates(end_coordinates)
    toa_forecast_data = end_forecast[:hourly][travel_time_hr - 1] # toa = time of arrival
    toa_forecast = HourlyForecast.new(toa_forecast_data)

    response = {
      "data": {
        "id": "null",
        "type": "foodie",
        "attributes": {
          "end_location": {
            "city": end_location.city,
            "state": end_location.state
          },
          "travel_time": "approximately #{travel_time_hr} hour(s)",
          "forecast": {
            "summary": toa_forecast.summary,
            "temperature": toa_forecast.temp
          },
          "restaurant": {
            "name": restaurant_name,
            "address": restaurant_address
          }
        }
      }
    }

    render json: response
  end

  private

  FORECAST_FACADE ||= ForecastFacade.new
  # if there was more time and this challenge was taking place in isolation without me having had already set up the facade specifically for the project, I would have named this differently since in this context it's only being used for geolocation

  WEATHER_SERVICE ||= WeatherService.new
end
