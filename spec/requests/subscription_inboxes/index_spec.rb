require 'rails_helper'

RSpec.describe :subscription_inbox_index, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { get inbox_subscription_inboxes_path(create(:subscription_inbox).inbox) }
  end

  it 'responds with the subscription_inbox resources' do
    subscription_inbox = create(:subscription_inbox)
    other_subscription_inbox = create(:subscription_inbox)

    get inbox_subscription_inboxes_path(subscription_inbox.inbox), headers: auth_headers_for(subscription_inbox.inbox.user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(subscription_inbox)
    expect(response_data).not_to have_resource(other_subscription_inbox)
    expect(response_included).to have_resource(subscription_inbox.subscription)
    expect(response_included).to have_resource(subscription_inbox.subscription.subscribable)
  end
end
