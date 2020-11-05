require 'rails_helper'

RSpec.describe :account_show, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      get account_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the user resource' do
      user = create(:user)

      get account_path, headers: auth_headers_for(user)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(user)
    end
  end
end
