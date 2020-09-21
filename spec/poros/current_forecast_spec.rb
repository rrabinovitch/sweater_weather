require 'rails_helper'

RSpec.describe CurrentForecast do
  it 'it has attributes' do
    data = {current: {:dt=>1600724767,
         :sunrise=>1600692427,
         :sunset=>1600736311,
         :temp=>83.57,
         :feels_like=>77.5,
         :pressure=>1021,
         :humidity=>13,
         :dew_point=>28.11,
         :uvi=>6.87,
         :clouds=>75,
         :visibility=>10000,
         :wind_speed=>3.36,
         :wind_deg=>90,
         :weather=>[{:id=>803, :main=>"Clouds", :description=>"broken clouds", :icon=>"04d"}]}}

    current_forecast = CurrentForecast.new(data)

    expect(current_forecast).to be_a(CurrentForecast)
    expect(current_forecast.datetime).to eq(1600724767)
    expect(current_forecast.temp).to eq(83.57)
    expect(current_forecast.description).to eq("broken clouds")
    expect(current_forecast.feels_like).to eq(77.5)
    expect(current_forecast.humidity).to eq(13)
    expect(current_forecast.visibility).to eq(10000)
    expect(current_forecast.uv_index).to eq(6.87)
    expect(current_forecast.sunrise).to eq(1600692427)
    expect(current_forecast.sunset).to eq(1600736311)
  end
end
