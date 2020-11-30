require 'rails_helper'

RSpec.describe :account_password_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch account_password_path }
  end

  it_behaves_like :unprocessable_request, [:password] do
    let(:subject) do
      user = create(:user, password: '123456')

      patch account_password_path,
        params: { current_password: '123456', new_password: '123' },
        headers: auth_headers_for(user)
    end
  end

  # FIXME: Add this case to shared examples
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
  end
end
