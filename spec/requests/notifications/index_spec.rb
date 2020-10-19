require 'rails_helper'

RSpec.describe :notifications_index, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      get notifications_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the user resources' do
      user = create(:user)
      sign_in user
      user_notification = create(:notification, user: user)
      other_notification = create(:notification)

      get notifications_path

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(user_notification)
      expect(response_data).not_to have_resource(other_notification)
    end
  end
end
