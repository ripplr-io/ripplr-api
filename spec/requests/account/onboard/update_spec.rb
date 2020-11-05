require 'rails_helper'

RSpec.describe :account_onboard_update, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      put account_onboard_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user owns the resource' do
    it 'responds with the resource' do
      user = create(:user)

      put account_onboard_path, headers: auth_headers_for(user)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(user)
    end
  end
end
