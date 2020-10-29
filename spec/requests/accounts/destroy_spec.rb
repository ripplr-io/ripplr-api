require 'rails_helper'

RSpec.describe :accounts_destroy, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      delete account_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with no content' do
      user = create(:user)
      sign_in user

      delete account_path

      expect(response).to have_http_status(:no_content)
    end
  end
end
