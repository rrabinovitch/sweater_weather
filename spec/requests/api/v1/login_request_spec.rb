require 'rails_helper'

RSpec.describe 'Login request' do
  it 'can successfully log in a user' do
    user = create(:user)
    login_params = {email: user.email,
                  password: user.password}

    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/sessions', params: JSON.generate(login_params), headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.content_type).to eq('application/json; charset=utf-8')
  end
end
