class Api::V1::ForecastController < ApplicationController
  def show
    location = params[:location]
    forecast = FORECAST_FACADE.get_forecast(location)
    render json: ForecastSerializer.new(forecast)
  end

  private

  FORECAST_FACADE ||= ForecastFacade.new
end
