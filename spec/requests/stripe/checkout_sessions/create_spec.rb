require 'rails_helper'

RSpec.describe :stripe_checkout_sessions_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post stripe_checkout_session_path }
  end

  context 'the user\'s stripe_customer_id is nil' do
    it 'creates a stripe customer' do
      billing = create(:billing, stripe_customer_id: nil)

      stub_request(:post, 'https://api.stripe.com/v1/customers').to_return(
        status: 200,
        body: { id: 'customer_id' }.to_json
      )

      stub_request(:post, 'https://api.stripe.com/v1/checkout/sessions').to_return(
        status: 200,
        body: { id: 'session_id' }.to_json
      )

      post stripe_checkout_session_path, headers: auth_headers_for(billing.user)

      expect(billing.reload.stripe_customer_id).not_to eq nil
    end

    it 'returns errors if the customer failed to create' do
      billing = create(:billing, stripe_customer_id: nil)

      stub_request(:post, 'https://api.stripe.com/v1/customers').to_return(status: 500)

      post stripe_checkout_session_path, headers: auth_headers_for(billing.user)

      expect(billing.reload.stripe_customer_id).to eq nil
      expect(response).to have_http_status(:bad_request)
    end
  end

  context 'the user\'s stripe_customer_id is present' do
    it 'uses the stripe customer' do
      billing = create(:billing, stripe_customer_id: 'customer_id')

      stub_request(:post, 'https://api.stripe.com/v1/checkout/sessions').to_return(
        status: 200,
        body: { id: 'session_id' }.to_json
      )

      post stripe_checkout_session_path, headers: auth_headers_for(billing.user)

      expect(billing.reload.stripe_customer_id).to eq 'customer_id'
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when the session is created' do
    it 'returns the new session id' do
      billing = create(:billing, stripe_customer_id: 'customer_id')

      stub_request(:post, 'https://api.stripe.com/v1/checkout/sessions').to_return(
        status: 200,
        body: { id: 'session_id' }.to_json
      )

      post stripe_checkout_session_path, headers: auth_headers_for(billing.user)

      expect(response).to have_http_status(:ok)
      expect(response_body[:sessionId]).to eq 'session_id'
    end
  end

  context 'when the session fails to create' do
    it 'returns errors' do
      billing = create(:billing, stripe_customer_id: 'customer_id')

      stub_request(:post, 'https://api.stripe.com/v1/checkout/sessions').to_return(status: 500)

      post stripe_checkout_session_path, headers: auth_headers_for(billing.user)

      expect(response).to have_http_status(:bad_request)
    end
  end
end
