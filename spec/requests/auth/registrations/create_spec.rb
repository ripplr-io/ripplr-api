require 'rails_helper'

RSpec.describe :auth_registrations_create, type: :request do
  it 'responds with the resource' do
    create(:level)

    post auth_register_path, params: {
      name: 'name',
      email: 'email@ripplr.io',
      password: 'password'
    }, as: :json

    expect(response).to have_http_status(:created)
    expect(response_body[:access_token]).not_to be nil
    expect(response_body[:refresh_token]).not_to be nil
  end

  it 'responds with errors' do
    create(:level)

    post auth_register_path, params: {
      email: 'email@ripplr.io'
    }

    expect(response).to have_http_status(:unprocessable_entity)
  end
end
