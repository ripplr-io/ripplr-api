require 'rails_helper'

RSpec.describe :inboxes_show, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { get feed_path }
  end

  it 'responds with the user resources' do
    user = create(:user)
    subscription = create(:subscription, user: user)
    push_notification = create(:push_notification, subscription: subscription)
    other_push_notification = create(:push_notification)

    get inbox_path, headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(push_notification.post)
    expect(response_data).not_to have_resource(other_push_notification.post)
  end
end
