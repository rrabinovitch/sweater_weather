require 'rails_helper'

RSpec.describe DailyForecast do
  it 'has attributes' do
    data = {:dt=>1600711200,
        :sunrise=>1600692427,
        :sunset=>1600736311,
        :temp=>{:day=>83.07, :min=>65.21, :max=>85.33, :night=>66.33, :eve=>83.12, :morn=>65.21},
        :feels_like=>{:day=>74.26, :night=>57.4, :eve=>74.66, :morn=>60.64},
        :pressure=>1018,
        :humidity=>15,
        :dew_point=>31.14,
        :wind_speed=>8.95,
        :wind_deg=>107,
        :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
        :clouds=>0,
        :pop=>0.04,
        :uvi=>6.48}

    daily_forecast = DailyForecast.new(data)

    expect(daily_forecast).to be_a(DailyForecast)
    expect(daily_forecast.datetime).to eq(1600711200)
    expect(daily_forecast.description).to eq("clear sky")
    expect(daily_forecast.precipitation).to eq(0)
    expect(daily_forecast.high_temp).to eq(85.33)
    expect(daily_forecast.low_temp).to eq(65.21)
  end
end
