require 'rails_helper'

RSpec.describe :subscriptions_index, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { get subscriptions_path }
  end

  it 'responds with the user resources' do
    user = create(:user)
    user_subscription = create(:subscription, user: user)
    other_subscription = create(:subscription)

    get subscriptions_path, headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(user_subscription)
    expect(response_data).not_to have_resource(other_subscription)
    expect(response_included).to have_resource(user_subscription.subscribable)
  end
end
