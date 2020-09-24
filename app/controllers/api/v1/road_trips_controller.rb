class Api::V1::RoadTripsController < ApplicationController
  def create
    user = User.find_by(api_key: road_trip_params[:api_key])
    if road_trip_params[:origin].nil? && road_trip_params[:destination].nil?
      render json: { error: 'Missing road trip origin and destination' }, status: 401
    elsif road_trip_params[:origin].nil?
      render json: { error: 'Missing road trip origin' }, status: 401
    elsif road_trip_params[:destination].nil?
      render json: { error: 'Missing road trip destination' }, status: 401
    elsif road_trip_params[:api_key].nil?
      render json: { error: 'Missing API key' }, status: 401
    elsif user.nil?
      render json: { error: 'Unsuccessful API key authentication' }, status: 401
    elsif user
      origin = road_trip_params[:origin]
      destination = road_trip_params[:destination]
      road_trip = RoadTripFacade.get_road_trip(origin, destination, user)
      render json: RoadTripSerializer.new(road_trip), status: 201
    end
  end

  private

  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end
end
