require 'rails_helper'

RSpec.describe :stripe_webhooks_create, type: :request do
  let(:stripe_subscription) do
    {
      customer: 'customer_id',
      status: 'status',
      current_period_end: Time.current + 5.days,
      items: {
        data: [
          {
            price: {
              product: 'product_id'
            }
          }
        ]
      }
    }
  end

  context 'customer.subscription.created' do
    it 'updates the billing' do
      post stripe_webhook_path, params: {
        type: 'customer.subscription.created',
        data: { object: stripe_subscription }
      }.to_json

      expect(response).to have_http_status(:ok)
      expect(Billings::UpdateWorker.jobs.size).to eq 1
    end
  end

  context 'customer.subscription.updated' do
    it 'updates the billing' do
      post stripe_webhook_path, params: {
        type: 'customer.subscription.updated',
        data: { object: stripe_subscription }
      }.to_json

      expect(response).to have_http_status(:ok)
      expect(Billings::UpdateWorker.jobs.size).to eq 1
    end
  end

  context 'customer.subscription.deleted' do
    it 'updates the billing' do
      post stripe_webhook_path, params: {
        type: 'customer.subscription.deleted',
        data: { object: stripe_subscription }
      }.to_json

      expect(response).to have_http_status(:ok)
      expect(Billings::UpdateWorker.jobs.size).to eq 1
    end
  end

  context 'invoice.paid' do
    it 'sends an alert' do
      post stripe_webhook_path, params: {
        type: 'invoice.paid',
        data: { object: { customer: 'customer', paid: 'true', payment_intent: 'pi_xxx' } }
      }.to_json

      expect(response).to have_http_status(:ok)
      expect(Alerts::InvoicePaymentWorker.jobs.size).to eq 1
    end
  end

  context 'invoice.payment_failed' do
    it 'sends an alert' do
      post stripe_webhook_path, params: {
        type: 'invoice.payment_failed',
        data: { object: { customer: 'customer', paid: 'false', payment_intent: 'pi_xxx' } }
      }.to_json

      expect(response).to have_http_status(:ok)
      expect(Alerts::InvoicePaymentWorker.jobs.size).to eq 1
    end
  end
end
