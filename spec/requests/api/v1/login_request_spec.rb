require 'rails_helper'

RSpec.describe 'Login request' do
  it 'is successful and returns user data if good credentials are submitted' do
    user = create(:user)
    login_params = {email: user.email,
                  password: user.password}

    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/sessions', params: JSON.generate(login_params), headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.content_type).to eq('application/json; charset=utf-8')

    login_json = JSON.parse(response.body, symbolize_names: true)
    expect(login_json[:data][:type]).to eq("user")
    expect(login_json[:data][:attributes][:email]).to eq(user.email)
    expect(login_json[:data][:attributes][:api_key]).to eq(user.api_key)
  end

  it 'is unsuccessful if email is not found in db' do
    login_params = {email: "whatever@example.com",
                  password: "password"}

    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/sessions', params: JSON.generate(login_params), headers: headers

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.content_type).to eq('application/json; charset=utf-8')

    no_login_json = JSON.parse(response.body, symbolize_names: true)
    expect(no_login_json[:body]).to eq('User not found')
  end

  it 'is unsuccessful if incorrect password submitted' do
    user = create(:user)
    login_params = {email: user.email,
                  password: "wrong_password"}

    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/sessions', params: JSON.generate(login_params), headers: headers

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.content_type).to eq('application/json; charset=utf-8')

    no_login_json = JSON.parse(response.body, symbolize_names: true)
    expect(no_login_json[:body]).to eq('Incorrect password')
  end
end
