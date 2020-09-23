require 'rails_helper'

RSpec.describe DailyForecast do
  it 'has attributes' do
    data = {:dt=>1600711200,
        :temp=>{:day=>83.07, :min=>65.21, :max=>85.33, :night=>66.33, :eve=>83.12, :morn=>65.21},
        :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}]}

    daily_forecast = DailyForecast.new(data)

    expect(daily_forecast).to be_a(DailyForecast)
    expect(daily_forecast.datetime).to eq(1600711200)
    expect(daily_forecast.description).to eq("clear sky")
    expect(daily_forecast.precipitation).to eq(0)
    expect(daily_forecast.high_temp).to eq(85.33)
    expect(daily_forecast.low_temp).to eq(65.21)
  end

  it 'can calculate total_precipitation when no rain & no snow' do
    data = {:dt=>1600711200,
        :temp=>{:day=>83.07, :min=>65.21, :max=>85.33, :night=>66.33, :eve=>83.12, :morn=>65.21},
        :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}]}

    daily_forecast = DailyForecast.new(data)
    expect(daily_forecast.precipitation).to eq(0)
  end

  it 'can calculate total_precipitation when no rain & yes snow' do
    data = {:dt => 1600797600,
        :temp=>{:day=>81.86, :min=>62.44, :max=>86.99, :night=>62.44, :eve=>77.85, :morn=>66.94},
        :weather=>[{:id=>500, :main=>"Rain", :description=>"light rain", :icon=>"10d"}],
        :snow=>2.01}

    daily_forecast = DailyForecast.new(data)
    expect(daily_forecast.precipitation).to eq(2.01)
  end

  it 'can calculate total_precipitation when yes rain & no snow' do
    data = {:dt => 1600797600,
        :temp=>{:day=>81.86, :min=>62.44, :max=>86.99, :night=>62.44, :eve=>77.85, :morn=>66.94},
        :weather=>[{:id=>500, :main=>"Rain", :description=>"light rain", :icon=>"10d"}],
        :rain=>1.58}

    daily_forecast = DailyForecast.new(data)
    expect(daily_forecast.precipitation).to eq(1.58)
  end

  it 'can calculate total_precipitation when yes rain & yes snow' do
    data = {:dt => 1600797600,
        :temp=>{:day=>81.86, :min=>62.44, :max=>86.99, :night=>62.44, :eve=>77.85, :morn=>66.94},
        :weather=>[{:id=>500, :main=>"Rain", :description=>"light rain", :icon=>"10d"}],
        :rain=>2.11,
        :snow=>1.05}

    daily_forecast = DailyForecast.new(data)
    expect(daily_forecast.precipitation).to eq(3.16)
  end
end
