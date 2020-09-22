class Api::V1::FoodieController < ApplicationController
  def show
    start_params = params[:start]
    end_params = params[:end]
    search_params = params[:search]

    # use start and end params as is to get directions and travel time
    # use end params and GeoService to obtain lat/long of end params
    # use lat/long for end params and search params via ZomatoService to obtain restaurant name and address
    # calculate time of arrival??
    # use lat/long for end params and time of arrival/travel time via WeatherService to access forecast at time of arrival
  end
end
