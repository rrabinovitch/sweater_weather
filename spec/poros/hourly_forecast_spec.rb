require 'rails_helper'

RSpec.describe HourlyForecast do
  it 'has attributes' do
    data = {:dt=>1600750800,
        :temp=>66.33,
        :feels_like=>60.1,
        :pressure=>1023,
        :humidity=>30,
        :dew_point=>34,
        :clouds=>40,
        :visibility=>10000,
        :wind_speed=>5.23,
        :wind_deg=>234,
        :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03n"}],
        :pop=>0.04}

    hourly_forecast = HourlyForecast.new(data)

    expect(hourly_forecast).to be_an(HourlyForecast)
    expect(hourly_forecast.datetime).to eq(1600750800)
    expect(hourly_forecast.temp).to eq(66.33)
  end
end
