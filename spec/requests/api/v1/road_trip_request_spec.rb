require 'rails_helper'

RSpec.describe 'Road trip request' do
  it 'returns successful response with origin, destination, travel time, and general forecast info' do
    user = create(:user)

    road_trip_params = {origin: "Denver, CO",
                    destination: "Pueblo, CO",
                    api_key: user.api_key}

    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/road_trip', params: JSON.generate(road_trip_params), headers: headers
    road_trip_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(response.content_type).to eq('application/json; charset=utf-8')

    roadtrip = RoadTrip.last

    expect(roadtrip_json[:data][:type]).to eq("road trip")
    expect(roadtrip_json[:data][:id]).to eq(roadtrip.id.to_s)
    expect(roadtrip_json[:data][:attributes][:origin]).to eq(roadtrip.origin)
    expect(roadtrip_json[:data][:attributes][:destination]).to eq(roadtrip.destination)
    # expect(roadtrip_json[:data][:attributes][:forecast][:temp]).to eq(???)
    # expect(roadtrip_json[:data][:attributes][:forecast][:description]).to eq(???)
  end
end
