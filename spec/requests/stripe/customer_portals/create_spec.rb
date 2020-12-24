require 'rails_helper'

RSpec.describe :stripe_customer_portals_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post stripe_customer_portal_path }
  end

  context 'session is created successfully' do
    it 'returns a valid session' do
      billing = create(:billing, stripe_customer_id: 'customer_id')

      stub_request(:post, 'https://api.stripe.com/v1/billing_portal/sessions').to_return(
        status: 200,
        body: { url: 'url' }.to_json
      )

      post stripe_customer_portal_path, headers: auth_headers_for(billing.user)

      expect(response).to have_http_status(:ok)
      expect(response_body[:url]).to eq 'url'
    end
  end

  context 'when the session fails to create' do
    it 'returns errors' do
      billing = create(:billing, stripe_customer_id: 'customer_id')

      stub_request(:post, 'https://api.stripe.com/v1/billing_portal/sessions').to_return(status: 500)

      post stripe_customer_portal_path, headers: auth_headers_for(billing.user)

      expect(response).to have_http_status(:bad_request)
    end
  end
end
