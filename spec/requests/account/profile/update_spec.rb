require 'rails_helper'

RSpec.describe :account_profile_update, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      patch account_profile_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
      user = create(:user)

      patch account_profile_path,
        params: user.as_json(only: [:name, :slug, :bio, :avatar]),
        headers: auth_headers_for(user)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(user)
    end

    it 'responds with errors' do
      user = create(:user)

      patch account_profile_path, params: { name: nil }, headers: auth_headers_for(user)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:name)
    end
  end
end
