require 'rails_helper'

RSpec.describe :subscriptions_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post subscriptions_path }
  end

  it_behaves_like :unprocessable_request, [:subscribable, :settings] do
    let(:subject) { post subscriptions_path, headers: auth_headers_for_new_user }
  end

  it 'responds with the resource' do
    user = create(:user)
    subscribable = create(:user)
    mock_subscription = build(:subscription, subscribable: subscribable)

    post subscriptions_path, params: mock_subscription.as_json(only: [
      :subscribable_id,
      :subscribable_type
    ]).merge(
      settings: mock_subscription.settings.to_json
    ), headers: auth_headers_for(user)

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(Subscription.last)
    expect(response_included).to have_resource(Subscription.last.subscribable)
  end
end
