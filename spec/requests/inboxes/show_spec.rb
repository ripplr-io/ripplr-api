require 'rails_helper'

RSpec.describe :inboxes_show, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      get feed_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the user resources' do
      user = create(:user)
      subscription = create(:subscription, user: user)
      push_notification = create(:push_notification, subscription: subscription)
      other_push_notification = create(:push_notification)

      sign_in user

      get inbox_path

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(push_notification.post)
      expect(response_data).not_to have_resource(other_push_notification.post)
    end
  end
end
