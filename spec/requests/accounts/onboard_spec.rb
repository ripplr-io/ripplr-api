require 'rails_helper'

RSpec.describe :accounts_onboard, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      post onboard_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user owns the resource' do
    it 'responds with the resource' do
      user = create(:user)
      sign_in user

      post onboard_path

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(user)
    end
  end
end
