require 'rails_helper'

RSpec.describe :account_password_update, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with not_found' do
      put account_password_path
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user is authenticated but does not provide the current password' do
    it 'responds with unauthorized' do
      user = create(:user)

      put account_password_path, headers: auth_headers_for(user)

      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated and provides the current password' do
    it 'responds with the resource' do
      user = create(:user, password: '123456')

      put account_password_path,
        params: { current_password: '123456', new_password: 'qwerty', new_password_confirmation: 'qwerty' },
        headers: auth_headers_for(user)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(user)
    end

    it 'responds with errors' do
      user = create(:user, password: '123456')

      put account_password_path,
        params: { current_password: '123456', new_password: '123' },
        headers: auth_headers_for(user)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:password)
    end
  end
end
