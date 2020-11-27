require 'rails_helper'

RSpec.describe :account_destroy, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with not_found' do
      delete account_path
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user is authenticated but does not provide the current password' do
    it 'responds with unauthorized' do
      user = create(:user)

      delete account_path, headers: auth_headers_for(user)

      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated and provides the current password' do
    it 'responds with no content' do
      user = create(:user, password: '123456')

      delete account_path, params: { current_password: '123456' }, headers: auth_headers_for(user)

      expect(response).to have_http_status(:no_content)
    end
  end
end
