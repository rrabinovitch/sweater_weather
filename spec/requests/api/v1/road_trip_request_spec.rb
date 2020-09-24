require 'rails_helper'

RSpec.describe 'Road trip request' do
  it 'returns successful response with origin, destination, travel time, and general forecast info' do
    user = create(:user)
    expect(user.road_trips.count).to eq(0)

    road_trip_params = {origin: "Denver, CO",
                    destination: "Pueblo, CO",
                    api_key: user.api_key}

    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/road_trip', params: JSON.generate(road_trip_params), headers: headers
    road_trip_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(response.content_type).to eq('application/json; charset=utf-8')

    road_trip = RoadTrip.last
    expect(user.road_trips.count).to eq(1)
    expect(user.road_trips.first).to eq(road_trip)

    expect(road_trip_json[:data][:type]).to eq("road_trip")
    expect(road_trip_json[:data][:id]).to eq(road_trip.id.to_s)
    expect(road_trip_json[:data][:attributes][:origin]).to eq(road_trip.origin)
    expect(road_trip_json[:data][:attributes][:destination]).to eq(road_trip.destination)
    expect(road_trip_json[:data][:attributes][:travel_time]).to eq(road_trip.travel_time)
    expect(road_trip_json[:data][:attributes][:forecast_temp]).to eq(road_trip.forecast_temp)
    expect(road_trip_json[:data][:attributes][:forecast_description]).to eq(road_trip.forecast_description)
    expect(road_trip_json[:data][:attributes][:user_id]).to eq(road_trip.user_id)
    expect(road_trip_json[:data][:attributes]).to_not have_key(:api_key)
  end

  it 'does not create a road trip and returns error if api key is not associated with actual user' do
    user = create(:user)
    expect(user.road_trips.count).to eq(0)

    road_trip_params = {origin: "Denver, CO",
                    destination: "Pueblo, CO",
                    api_key: "123wrongkey321"}

    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/road_trip', params: JSON.generate(road_trip_params), headers: headers

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.content_type).to eq('application/json; charset=utf-8')

    no_road_trip_json = JSON.parse(response.body, symbolize_names: true)
    expect(no_road_trip_json[:error]).to eq('Unsuccessful API key authentication')

    expect(user.road_trips.count).to eq(0)
  end

  it 'does not create a road trip and returns error if api key not included in request body' do
    user = create(:user)
    expect(user.road_trips.count).to eq(0)

    road_trip_params = {origin: "Denver, CO",
                    destination: "Pueblo, CO"}

    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/road_trip', params: JSON.generate(road_trip_params), headers: headers

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.content_type).to eq('application/json; charset=utf-8')

    no_road_trip_json = JSON.parse(response.body, symbolize_names: true)
    expect(no_road_trip_json[:error]).to eq('Missing API key')

    expect(user.road_trips.count).to eq(0)
  end

  xit 'does not create a road trip and returns error if origin param not included in request body' do
    user = create(:user)
    expect(user.road_trips.count).to eq(0)

    road_trip_params = {destination: "Pueblo, CO",
                    api_key: user.api_key}

    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/road_trip', params: JSON.generate(road_trip_params), headers: headers

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.content_type).to eq('application/json; charset=utf-8')

    no_road_trip_json = JSON.parse(response.body, symbolize_names: true)
    expect(no_road_trip_json[:error]).to eq('Missing road trip origin')

    expect(user.road_trips.count).to eq(0)
  end

  xit 'does not create a road trip and returns error if destination param not included in request body' do
    user = create(:user)
    expect(user.road_trips.count).to eq(0)

    road_trip_params = {origin: "Denver, CO",
                    api_key: user.api_key}

    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/road_trip', params: JSON.generate(road_trip_params), headers: headers

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.content_type).to eq('application/json; charset=utf-8')

    no_road_trip_json = JSON.parse(response.body, symbolize_names: true)
    expect(no_road_trip_json[:error]).to eq('Missing road trip destination')

    expect(user.road_trips.count).to eq(0)
  end
end
