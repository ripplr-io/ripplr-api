require 'rails_helper'

RSpec.describe :notifications_read, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      put read_notification_path(0)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
      user = create(:user)

      notification = create(:new_comment, user: user)

      put read_notification_path(notification), headers: auth_headers_for(user)

      expect(response).to have_http_status(:no_content)
      expect(notification.reload.read_at).not_to be(nil)
    end
  end
end
