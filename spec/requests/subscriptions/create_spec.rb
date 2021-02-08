require 'rails_helper'

RSpec.describe :subscriptions_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post subscriptions_path }
  end

  it_behaves_like :unprocessable_request, [:subscribable] do
    let(:subject) { post subscriptions_path, headers: auth_headers_for_new_user }
  end

  it 'responds with the resource' do
    user = create(:user)
    subscribable = create(:user)
    inbox_a = create(:inbox, user: user)
    inbox_b = create(:inbox, user: user)

    mock_subscription = build(:subscription, subscribable: subscribable)

    post subscriptions_path, params: mock_subscription.as_json(only: [
      :subscribable_id,
      :subscribable_type
    ]).merge(
      settings: mock_subscription.settings.to_json,
      inbox_ids: [inbox_a.id]
    ), headers: auth_headers_for(user)

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(Subscription.last)
    expect(response_included).to have_resource(Subscription.last.subscribable)
    expect(Subscription.last.inboxes).to include(inbox_a)
    expect(Subscription.last.inboxes).not_to include(inbox_b)
  end
end
