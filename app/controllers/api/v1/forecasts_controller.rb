class Api::V1::ForecastsController < ApplicationController
  def show
    location = params[:location]

    forecast = FORECAST_FACADE.get_forecast(location)

    # current_forecast = CurrentForecast.new(forecast_data)
    # hourly_forecast = HourlyForecast.new(forecast_data)
    # daily_forecast = DailyForecast.new(forecast_data)

    render json: forecast
  end

  private

  FORECAST_FACADE ||= ForecastFacade.new
end
