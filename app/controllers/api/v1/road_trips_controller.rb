class Api::V1::RoadTripsController < ApplicationController
  def create
    origin = road_trip_params[:origin]
    destination = road_trip_params[:destination]
    user = User.find_by(api_key: road_trip_params[:api_key])
    if user
      road_trip = RoadTripFacade.get_road_trip(origin, destination, user)
      render json: RoadTripSerializer.new(road_trip), status: 201
      ### road_trip = RoadTrip.create(road_trip_params)

      # try to create road trip
      # if road trip is successfully created
        # render json road trip info and 201 status
      # else (ie, if origin or destination info is missing)
        # render json error messages and 400 status
      # end
    # else
      # render json error message and 401 unauthorized status
    end
  end

  private

  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end
end
