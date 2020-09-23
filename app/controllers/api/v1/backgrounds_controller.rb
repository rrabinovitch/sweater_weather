class Api::V1::BackgroundsController < ApplicationController
  def show
    location = params[:location]
    image = BackgroundFacade.get_location_img(location)
    render json: ImageSerializer.new(image)
  end
end
