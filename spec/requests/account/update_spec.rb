require 'rails_helper'

RSpec.describe :account_update, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with not_found' do
      patch account_path
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user owns the resource' do
    it 'responds with the resource' do
      user = create(:user)

      patch account_path,
        params: user.as_json(only: [:country, :email, :timezone]),
        headers: auth_headers_for(user)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(user)
    end

    it 'responds with errors' do
      user = create(:user)

      patch account_path, params: { timezone: nil }, headers: auth_headers_for(user)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:timezone)
    end
  end
end
