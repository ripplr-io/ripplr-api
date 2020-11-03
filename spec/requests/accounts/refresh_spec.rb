require 'rails_helper'

RSpec.describe :accounts_onboard, type: :request do
  context 'when the token is invalid' do
    it 'responds with unauthorized' do
      token = 'random_token'

      get refresh_path, params: nil, headers: { Authorization: "Bearer #{token}" }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the token is valid' do
    it 'refreshes the token' do
      user = create(:user)
      original_jti = user.jti
      token = Warden::JWTAuth::UserEncoder.new.call(user, :users, Rails.application.credentials.secret_key_base)[0]

      get refresh_path, params: nil, headers: { Authorization: "Bearer #{token}" }

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(user)
      expect(response.headers['Authorization']).to start_with('Bearer')
      expect(response.headers['Authorization']).not_to eq("Bearer #{token}")
      expect(user.reload.jti).not_to eq(original_jti)
    end
  end
end
