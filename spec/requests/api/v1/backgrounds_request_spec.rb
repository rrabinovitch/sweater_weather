require 'rails_helper'

RSpec.describe 'Backgrounds request' do
  it 'returns successful JSON API v1 response with image data and credits' do
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

    expect(background_json[:data][:attributes][:credit]).to have_key(:author)
    expect(background_json[:data][:attributes][:credit][:author]).to be_a(String)

    expect(background_json[:data][:attributes][:credit]).to have_key(:logo)
    expect(background_json[:data][:attributes][:credit][:logo]).to be_a(String)
  end
end


# {:total_results=>179,
#  :page=>1,
#  :per_page=>1,
#  :photos=>
#   [{:id=>3184423,
#     :width=>4004,
#     :height=>6000,
#     :url=>"https://www.pexels.com/photo/photo-of-people-holding-each-other-s-hands-3184423/",
#     :photographer=>"fauxels",
#     :photographer_url=>"https://www.pexels.com/@fauxels",
#     :photographer_id=>1281351,
#     :src=>
#      {:original=>"https://images.pexels.com/photos/3184423/pexels-photo-3184423.jpeg",
#       :large2x=>"https://images.pexels.com/photos/3184423/pexels-photo-3184423.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
#       :large=>"https://images.pexels.com/photos/3184423/pexels-photo-3184423.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
#       :medium=>"https://images.pexels.com/photos/3184423/pexels-photo-3184423.jpeg?auto=compress&cs=tinysrgb&h=350",
#       :small=>"https://images.pexels.com/photos/3184423/pexels-photo-3184423.jpeg?auto=compress&cs=tinysrgb&h=130",
#       :portrait=>"https://images.pexels.com/photos/3184423/pexels-photo-3184423.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
#       :landscape=>"https://images.pexels.com/photos/3184423/pexels-photo-3184423.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
#       :tiny=>"https://images.pexels.com/photos/3184423/pexels-photo-3184423.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"},
#     :liked=>false}],
#  :next_page=>"https://api.pexels.com/v1/search/?page=2&per_page=1&query=denver%2Cco"}
