require 'rails_helper'

RSpec.describe :notifications_read_all, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      post read_notifications_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
      user = create(:user)

      notification_a = create(:new_comment, user: user)
      notification_b = create(:new_comment, user: user)
      notification_other_user = create(:new_comment)

      post read_notifications_path, headers: auth_headers_for(user)

      expect(response).to have_http_status(:no_content)
      expect(notification_a.reload.read_at).not_to be(nil)
      expect(notification_b.reload.read_at).not_to be(nil)
      expect(notification_other_user.reload.read_at).to be(nil)
    end
  end
end
