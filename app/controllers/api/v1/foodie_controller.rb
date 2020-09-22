class Api::V1::FoodieController < ApplicationController
  def show
    start_params = params[:start]
    end_params = params[:end]
    search_params = params[:search]

    response = FOODIE_FACADE.get_foodie_route_info(start_params, end_params, search_params)

    render json: response
  end

  private

  FOODIE_FACADE ||= FoodieFacade.new
end
