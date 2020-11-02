require 'rails_helper'

RSpec.describe :accounts_registrations_create, type: :request do
  it 'responds with the resource' do
    create(:level)

    post user_registration_path, as: :json, params: {
      name: 'name',
      email: 'email@ripplr.io',
      password: 'password'
    }

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(User.last)
    expect(response.headers['Authorization']).to start_with('Bearer')
  end

  it 'responds with errors' do
    create(:level)

    post user_registration_path, as: :json, params: {
      email: 'email@ripplr.io'
    }

    expect(response).to have_http_status(:unprocessable_entity)
  end
end
