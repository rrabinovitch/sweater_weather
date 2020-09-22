require 'rails_helper'

RSpec.describe 'Forecast request' do
  it 'successfully returns a city\'s forecast and includes:
        - location
        - current forecast
        - hourly forecast
        - daily forecast' do

    VCR.use_cassette('Denver forecast') do
      get '/api/v1/forecast?location=denver,co'
      expect(response).to be_successful
      # expect(response.content_type).to eq('application/json')
      # => returning "application/json; charset=utf-8" for some reason
      forecast_json = JSON.parse(response.body, symbolize_names: true)
      #### COME BACK TO TEST ACTUAL CONTENT
      expect(forecast_json[:data]).to have_key(:id)
      expect(forecast_json[:data][:type]).to eq("forecast")
      expect(forecast_json[:data][:attributes]).to have_key(:location)
      expect(forecast_json[:data][:attributes][:location]).to have_key(:coordinates)
      expect(forecast_json[:data][:attributes][:location][:coordinates]).to have_key(:lat)
      expect(forecast_json[:data][:attributes][:location][:coordinates]).to have_key(:lng)
      expect(forecast_json[:data][:attributes][:location]).to have_key(:city)
      expect(forecast_json[:data][:attributes][:location]).to have_key(:state)
      expect(forecast_json[:data][:attributes][:location]).to have_key(:country)
      expect(forecast_json[:data][:attributes]).to have_key(:current)
      expect(forecast_json[:data][:attributes][:current]).to have_key(:datetime)
      expect(forecast_json[:data][:attributes][:current]).to have_key(:temp)
      expect(forecast_json[:data][:attributes][:current]).to have_key(:description)
      expect(forecast_json[:data][:attributes][:current]).to have_key(:feels_like)
      expect(forecast_json[:data][:attributes][:current]).to have_key(:humidity)
      expect(forecast_json[:data][:attributes][:current]).to have_key(:visibility)
      expect(forecast_json[:data][:attributes][:current]).to have_key(:uv_index)
      expect(forecast_json[:data][:attributes][:current]).to have_key(:sunrise)
      expect(forecast_json[:data][:attributes][:current]).to have_key(:sunset)
      expect(forecast_json[:data][:attributes]).to have_key(:hourly)
      expect(forecast_json[:data][:attributes][:hourly].size).to eq(8)
      expect(forecast_json[:data][:attributes][:hourly].first).to have_key(:datetime)
      expect(forecast_json[:data][:attributes][:hourly].first).to have_key(:temp)
      expect(forecast_json[:data][:attributes]).to have_key(:daily)
      expect(forecast_json[:data][:attributes][:daily].size).to eq(5)
      expect(forecast_json[:data][:attributes][:daily].first).to have_key(:datetime)
      expect(forecast_json[:data][:attributes][:daily].first).to have_key(:description)
      expect(forecast_json[:data][:attributes][:daily].first).to have_key(:precipitation)
      expect(forecast_json[:data][:attributes][:daily].first).to have_key(:high_temp)
      expect(forecast_json[:data][:attributes][:daily].first).to have_key(:low_temp)
    end
  end
end
