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

    expect(foodie_route_json[:data]).to have_key(:id)
    expect(foodie_route_json[:data][:type]).to eq("foodie")
    # expect(foodie_route_json[:data][:attributes]).to have_key(:)
  end
end
