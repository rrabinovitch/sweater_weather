require 'rails_helper'

RSpec.describe 'Backgrounds request' do
  it 'returns successful JSON API v1 response with image data and credits' do
    get '/api/v1/backgrounds?location=denver,co'
    @background_json = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(@background_json[:data][:type]).to eq("image")
    expect(@background_json[:data]).to have_key(:id)

    expect(@background_json[:data][:attributes]).to have_key(:location)
    expect(@background_json[:data][:attributes][:location]).to be_a(String)

    expect(@background_json[:data][:attributes]).to have_key(:image_url)
    expect(@background_json[:data][:attributes][:image_url]).to be_a(String)

    expect(@background_json[:data][:attributes]).to have_key(:credit)
    expect(@background_json[:data][:attributes][:credit]).to be_a(Hash)

    expect(@background_json[:data][:attributes][:credit]).to have_key(:source)
    expect(@background_json[:data][:attributes][:credit][:source]).to be_a(String)

    expect(@background_json[:data][:attributes][:credit]).to have_key(:author)
    expect(@background_json[:data][:attributes][:credit][:author]).to be_a(String)

    expect(@background_json[:data][:attributes][:credit]).to have_key(:logo)
    expect(@background_json[:data][:attributes][:credit][:logo]).to be_a(String)
  end
end
