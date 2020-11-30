require 'rails_helper'

RSpec.describe :notifications_read, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { put read_notification_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      notification = create(:new_comment)
      put read_notification_path(notification), headers: auth_headers_for_new_user
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    notification = create(:new_comment, user: user)

    put read_notification_path(notification), headers: auth_headers_for(user)

    expect(response).to have_http_status(:no_content)
    expect(notification.reload.read_at).not_to be(nil)
  end
end
