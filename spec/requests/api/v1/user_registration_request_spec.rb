require 'rails_helper'

RSpec.describe 'User registration request' do
  it 'can successfully create a user' do
    user_params = {email: "whatever@example.com",
                password: "password",
                password_confirmation: "password"}

    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/users', params: JSON.generate(user_params), headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(response.content_type).to eq('application/json; charset=utf-8')

    user = User.last

    user_json = JSON.parse(response.body, symbolize_names: true)
    expect(user_json[:data][:type]).to eq("user")
    expect(user_json[:data][:id]).to eq(user.id.to_s)
    expect(user_json[:data][:attributes][:email]).to eq(user.email)
    expect(user_json[:data][:attributes][:api_key]).to eq(user.api_key)
  end

  it 'does not create a user if the password fields do not match' do
    user_params = {email: "whatever@example.com",
                password: "password",
                password_confirmation: "password1"}

    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/users', params: JSON.generate(user_params), headers: headers

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(response.content_type).to eq('application/json; charset=utf-8')

    expect(User.all.count).to eq(0)

    bad_request_json = JSON.parse(response.body, symbolize_names: true)
    expect(bad_request_json[:body]).to eq("Password confirmation doesn't match Password")
  end

  it 'does not create a user if the email submitted is already in use' do
    create(:user)
    expect(User.all.count).to eq(1)

    user_params = {email: "whatever@example.com",
                password: "password",
                password_confirmation: "password"}

    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/users', params: JSON.generate(user_params), headers: headers

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(response.content_type).to eq('application/json; charset=utf-8')

    expect(User.all.count).to eq(1)

    bad_request_json = JSON.parse(response.body, symbolize_names: true)
    expect(bad_request_json[:body]).to eq("Email has already been taken")
  end

  it 'does not create a user if the email field is missing' do
    user_params = {password: "password",
                password_confirmation: "password"}

    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/users', params: JSON.generate(user_params), headers: headers

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(response.content_type).to eq('application/json; charset=utf-8')

    expect(User.all.count).to eq(0)

    bad_request_json = JSON.parse(response.body, symbolize_names: true)
    expect(bad_request_json[:body]).to eq("Email can't be blank")
  end

  it 'does not create a user if the password field is missing' do

  end
end
