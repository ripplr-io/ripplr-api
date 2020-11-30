require 'rails_helper'

RSpec.describe :subscriptions_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch subscription_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      subscription = create(:subscription)
      patch subscription_path(subscription), headers: auth_headers_for_new_user
    end
  end

  it_behaves_like :unprocessable_request, [:subscribable] do
    let(:subject) do
      subscription = create(:subscription)

      patch subscription_path(subscription),
        params: { subscribable_id: nil },
        headers: auth_headers_for(subscription.user)
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    subscription = create(:subscription, user: user)

    patch subscription_path(subscription), params: subscription.as_json(only: [
      :subscribable_id,
      :subscribable_type
    ]).merge(
      settings: subscription.settings.to_json
    ), headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(subscription)
    expect(response_included).to have_resource(subscription.subscribable)
  end
end
