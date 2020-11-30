require 'rails_helper'

RSpec.describe :subscriptions_destroy, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { delete subscription_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      subscription = create(:subscription)
      delete subscription_path(subscription), headers: auth_headers_for_new_user
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    subscription = create(:subscription, user: user)

    delete subscription_path(subscription), headers: auth_headers_for(user)

    expect(response).to have_http_status(:no_content)
  end
end
