require 'rails_helper'

RSpec.describe 'User registration request' do
  it 'can successfully create a user' do
    user_params = {email: "whatever@example.com",
                password: "password",
                password_confirmation: "password"}

    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/users', params: JSON.generate(user_params), headers: headers

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    user = User.last

    user_json = JSON.parse(response.body, symbolize_names: true)
    expect(user_json[:data][:type]).to eq("user")
    expect(user_json[:data][:id]).to eq(user.id.to_s)
    expect(user_json[:data][:attributes][:email]).to eq(user.email)
    expect(user_json[:data][:attributes][:api_key]).to eq(user.api_key)
  end
end
