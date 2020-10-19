require 'rails_helper'

RSpec.describe :profiles_update, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      patch profile_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
      user = create(:user)
      sign_in user

      patch profile_path, as: :json, params: user.as_json(only: [:name, :slug, :bio, :avatar])

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(user)
    end

    it 'responds with errors' do
      user = create(:user)
      sign_in user

      patch profile_path, as: :json, params: { name: nil }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:name)
    end
  end
end
