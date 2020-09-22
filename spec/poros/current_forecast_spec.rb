require 'rails_helper'

RSpec.describe CurrentForecast do
  it 'has attributes' do
    data = {:dt=>1600750707,
       :sunrise=>1600692427,
       :sunset=>1600736311,
       :temp=>66.42,
       :feels_like=>56.73,
       :pressure=>1023,
       :humidity=>30,
       :dew_point=>34.07,
       :uvi=>6.48,
       :clouds=>40,
       :visibility=>10000,
       :wind_speed=>11.41,
       :wind_deg=>210,
       :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03n"}]}

    current_forecast = CurrentForecast.new(data)

    expect(current_forecast).to be_a(CurrentForecast)
    expect(current_forecast.datetime).to eq(1600750707)
    expect(current_forecast.temp).to eq(66.42)
    expect(current_forecast.description).to eq("scattered clouds")
    expect(current_forecast.feels_like).to eq(56.73)
    expect(current_forecast.humidity).to eq(30)
    expect(current_forecast.visibility).to eq(10000)
    expect(current_forecast.uv_index).to eq(6.48)
    expect(current_forecast.sunrise).to eq(1600692427)
    expect(current_forecast.sunset).to eq(1600736311)
  end
end
