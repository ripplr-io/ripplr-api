require 'rails_helper'

RSpec.describe :accounts_sessions_create, type: :request do
  it 'responds with the resource' do
    user = create(:user, email: 'email@ripplr.io', password: '123456')

    post user_session_path, as: :json, params: {
      email: 'email@ripplr.io',
      password: '123456'
    }

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(user)
    expect(response.headers['Authorization']).to start_with('Bearer')
  end

  it 'responds with errors' do
    post user_session_path, as: :json, params: {
      email: 'email@example.com',
      password: 'password'
    }

    expect(response).to have_http_status(:unauthorized)
    expect(response_body[:error]).to eq 'Invalid Email or password.'
  end
end
