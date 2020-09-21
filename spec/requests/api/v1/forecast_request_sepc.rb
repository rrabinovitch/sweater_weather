require 'rails_helper'

RSpec.describe 'Forecast request' do
  describe 'can obtain a city\'s forecast, including:' do
    before :each do
      # pretty sure no objects need to be created
      get '/api/v1/forecast?location=denver,co'
    end

    it 'weather summary' do

    end

    it 'current time and date' do

    end

    it 'feels like (integer)' do

    end

    it 'humidity (percentage)' do

    end

    it 'visibility (miles)' do

    end

    it 'UV index (integer and level)' do

    end

    it 'sunrise and sunset times' do

    end

    it '8hr forecast' do

    end

    it '5-day forecast, including summary, precipitation, high temp, and low temp' do

    end


  end
end
