require 'rails_helper'

RSpec.describe 'Foodie route request' do
  it 'can retrieve food and forecast information for a destination city, including:
        - the end city
        - estimated travel time
        - the name and address of a restaurant that matches the search parameter
        - the forecast at your time of arrival' do


    get '/api/v1/foodie?start=denver,co&end=pueblo,co&search=italian'
    expect(response).to be_successful
    foodie_route_json = JSON.parse(response.body, symbolize_names: true)

    expect(foodie_route_json[:data][:id]).to eq("null")
    expect(foodie_route_json[:data][:type]).to eq("foodie")
    expect(foodie_route_json[:data][:attributes][:end_location]).to have_key(:city)
    expect(foodie_route_json[:data][:attributes][:end_location]).to have_key(:state)
    expect(foodie_route_json[:data][:attributes]).to have_key(:travel_time)
    expect(foodie_route_json[:data][:attributes][:forecast]).to have_key(:summary)
    expect(foodie_route_json[:data][:attributes][:forecast]).to have_key(:temperature)
    expect(foodie_route_json[:data][:attributes][:restaurant]).to have_key(:name)
    expect(foodie_route_json[:data][:attributes][:restaurant]).to have_key(:address)
  end
end
