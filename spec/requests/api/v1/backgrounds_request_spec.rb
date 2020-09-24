require 'rails_helper'

RSpec.describe 'Backgrounds request' do
  it 'returns successful response with image data and credits' do
    VCR.use_cassette('Denver image') do
      get '/api/v1/backgrounds?location=denver,co'
      background_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(background_json[:data][:type]).to eq("image")
      expect(background_json[:data]).to have_key(:id)

      expect(background_json[:data][:attributes]).to have_key(:location)
      expect(background_json[:data][:attributes][:location]).to be_a(String)

      expect(background_json[:data][:attributes]).to have_key(:image_url)
      expect(background_json[:data][:attributes][:image_url]).to be_a(String)

      expect(background_json[:data][:attributes]).to have_key(:credit)
      expect(background_json[:data][:attributes][:credit]).to be_a(Hash)

      expect(background_json[:data][:attributes][:credit]).to have_key(:source)
      expect(background_json[:data][:attributes][:credit][:source]).to be_a(String)

      expect(background_json[:data][:attributes][:credit]).to have_key(:photographer)
      expect(background_json[:data][:attributes][:credit][:photographer]).to be_a(String)
    end
  end
end
