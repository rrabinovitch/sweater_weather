class Api::V1::RoadTripsController < ApplicationController
  def create
    # if api key is authenticated
      # try to create road trip
      # if road trip is successfully created
        # render json road trip info and 201 status
      # else (ie, if origin or destination info is missing)
        # render json error messages and 400 status
      # end
    # else
      # render json error message and 401 unauthorized status
    # end
    binding.pry
  end

  private

  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end
end
