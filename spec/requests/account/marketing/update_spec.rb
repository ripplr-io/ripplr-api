require 'rails_helper'

RSpec.describe :account_marketing_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch account_marketing_path }
  end

  it 'responds with the resource' do
    user = create(:user, subscribed_to_marketing: false)

    put account_marketing_path,
      params: { subscribed_to_marketing: true },
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(user)
    expect(user.reload.subscribed_to_marketing).to eq true
  end
end
