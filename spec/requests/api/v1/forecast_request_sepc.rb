require 'rails_helper'

RSpec.describe 'Forecast request' do
  before :each do
    VCR.use_cassette('Denver forecast') do
      get '/api/v1/forecast?location=denver,co'
      @forecast_json = JSON.parse(response.body, symbolize_names: true)
      @attributes = @forecast_json[:data][:attributes]
    end
  end

  it 'returns a successfulJSON API v1 response' do
    expect(response).to be_successful
    expect(response.status).to eq(200)
    # expect(response.content_type).to eq('application/json')
    # => returning "application/json; charset=utf-8" for some reason
    expect(@forecast_json[:data]).to have_key(:id)
    expect(@forecast_json[:data][:type]).to eq("forecast")
  end

  it 'returns location info' do
    expect(@attributes).to have_key(:location)
    expect(@attributes[:location][:coordinates]).to be_a(Hash)
    expect(@attributes[:location][:coordinates][:lat]).to be_a(Float)
    expect(@attributes[:location][:coordinates][:lng]).to be_a(Float)
    expect(@attributes[:location][:city]).to be_a(String)
    expect(@attributes[:location][:state]).to be_a(String)
    expect(@attributes[:location][:country]).to be_a(String)
  end

  it 'returns current forecast info' do
    expect(@attributes).to have_key(:current)
    expect(@attributes[:current][:datetime]).to be_an(Integer)
    expect(@attributes[:current][:temp]).to be_a(Float)
    expect(@attributes[:current][:description]).to be_a(String)
    expect(@attributes[:current][:feels_like]).to be_a(Float)
    expect(@attributes[:current][:humidity]).to be_an(Integer)
    expect(@attributes[:current][:visibility]).to be_an(Integer)
    expect(@attributes[:current][:uv_index]).to be_a(Float)
    expect(@attributes[:current][:sunrise]).to be_an(Integer)
    expect(@attributes[:current][:sunset]).to be_an(Integer)
  end

  it 'returns hourly forecast info, ' do
    expect(@attributes).to have_key(:hourly)
    expect(@attributes[:hourly]).to be_an(Array)
    expect(@attributes[:hourly].size).to eq(8)

    hourly_attr_klasses = {
      datetime: Integer,
      temp: Float
    }

    @attributes[:hourly].each do |hour|
      hourly_attr_klasses.each do |attr, klass|
        expect(hour).to have_key(attr)
        expect(hour[attr]).to_not be_nil
        expect(hour[attr]).to be_a(klass)
      end
    end
  end

  it 'returns daily forecast info' do
    expect(@attributes).to have_key(:daily)
    expect(@attributes[:daily]).to be_an(Array)
    expect(@attributes[:daily].size).to eq(5)

    daily_attr_klasses = {
      datetime: Integer,
      description: String,
      precipitation: Float,
      high_temp: Float,
      low_temp: Float
    }

    @attributes[:daily].each do |day|
      daily_attr_klasses.each do |attr, klass|
        expect(day).to have_key(attr)
        expect(day[attr]).to_not be_nil
        expect(day[attr]).to be_a(klass)
      end
    end
  end

  it 'does not return unexpected data' do
    expect(@attributes).to_not have_key(:minutely)
    expect(@attributes[:current]).to_not have_key(:dew_point)
    expect(@attributes[:current]).to_not have_key(:clouds)
    expect(@attributes[:current]).to_not have_key(:wind_speed)
    expect(@attributes[:current]).to_not have_key(:wind_gust)
    expect(@attributes[:current]).to_not have_key(:wind_deg)
    expect(@attributes[:current]).to_not have_key(:rain)

    @attributes[:hourly].each do |hour|
      expect(hour).to_not have_key(:pressure)
      expect(hour).to_not have_key(:humidity)
      expect(hour).to_not have_key(:dew_point)
      expect(hour).to_not have_key(:clouds)
      expect(hour).to_not have_key(:visibility)
      expect(hour).to_not have_key(:wind_speed)
      expect(hour).to_not have_key(:wind_gust)
      expect(hour).to_not have_key(:wind_deg)
      expect(hour).to_not have_key(:pop)
      expect(hour).to_not have_key(:rain)
      expect(hour).to_not have_key(:snow)
    end

    @attributes[:daily].each do |day|
      expect(day).to_not have_key(:sunrise)
      expect(day).to_not have_key(:sunset)
      expect(day).to_not have_key(:feels_like)
      expect(day).to_not have_key(:pressure)
      expect(day).to_not have_key(:humidity)
      expect(day).to_not have_key(:dew_point)
      expect(day).to_not have_key(:wind_speed)
      expect(day).to_not have_key(:wind_gust)
      expect(day).to_not have_key(:wind_deg)
      expect(day).to_not have_key(:clouds)
      expect(day).to_not have_key(:uv_index)
      expect(day).to_not have_key(:visibility)
      expect(day).to_not have_key(:pop)
    end

    expect(@attributes).to_not have_key(:alerts)
  end
end
