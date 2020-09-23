class Api::V1::BackgroundsController < ApplicationController
  def show
    location = params[:location]

    image = BACKGROUND_FACADE.get_location_img(location)

    render json: image

  end

  private

  BACKGROUND_FACADE ||= BackgroundFacade.new
end
