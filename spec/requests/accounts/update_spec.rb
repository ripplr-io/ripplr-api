require 'rails_helper'

RSpec.describe :accounts_update, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      patch account_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user owns the resource' do
    it 'responds with the resource' do
      user = create(:user)
      sign_in user

      patch account_path, as: :json, params: user.as_json(only: [:country, :email, :timezone])

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(user)
    end

    it 'responds with errors' do
      user = create(:user)
      sign_in user

      patch account_path, as: :json, params: { timezone: nil }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:timezone)
    end
  end
end
