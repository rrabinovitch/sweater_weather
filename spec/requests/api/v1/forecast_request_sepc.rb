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

      expect(forecast_json[:data]).to have_key(:id)
      expect(forecast_json[:data][:type]).to eq("forecast")

      attributes = forecast_json[:data][:attributes]

      expect(attributes).to have_key(:location)
      expect(attributes[:location][:coordinates]).to be_a(Hash)
      expect(attributes[:location][:coordinates][:lat]).to be_a(Float)
      expect(attributes[:location][:coordinates][:lng]).to be_a(Float)
      expect(attributes[:location][:city]).to be_a(String)
      expect(attributes[:location][:state]).to be_a(String)
      expect(attributes[:location][:country]).to be_a(String)

      expect(attributes).to have_key(:current)
      expect(attributes[:current][:datetime]).to be_an(Integer)
      expect(attributes[:current][:temp]).to be_a(Float)
      expect(attributes[:current][:description]).to be_a(String)
      expect(attributes[:current][:feels_like]).to be_a(Float)
      expect(attributes[:current][:humidity]).to be_an(Integer)
      expect(attributes[:current][:visibility]).to be_an(Integer)
      expect(attributes[:current][:uv_index]).to be_a(Float)
      expect(attributes[:current][:sunrise]).to be_an(Integer)
      expect(attributes[:current][:sunset]).to be_an(Integer)

      expect(attributes).to have_key(:hourly)
      expect(attributes[:hourly]).to be_an(Array)
      expect(attributes[:hourly].size).to eq(8)

      hourly_attr_klasses = {
        datetime: Integer,
        temp: Float
      }

      attributes[:hourly].each do |hour|
        hourly_attr_klasses.each do |attr, klass|
          expect(hour).to have_key(attr)
          expect(hour[attr]).to_not be_nil
          expect(hour[attr]).to be_a(klass)
        end
      end

      expect(attributes).to have_key(:daily)
      expect(attributes[:daily]).to be_an(Array)
      expect(attributes[:daily].size).to eq(5)

      daily_attr_klasses = {
        datetime: Integer,
        description: String,
        precipitation: Float,
        high_temp: Float,
        low_temp: Float
      }

      attributes[:daily].each do |day|
        daily_attr_klasses.each do |attr, klass|
          expect(day).to have_key(attr)
          expect(day[attr]).to_not be_nil
          expect(day[attr]).to be_a(klass)
        end
      end
    end
  end
end
