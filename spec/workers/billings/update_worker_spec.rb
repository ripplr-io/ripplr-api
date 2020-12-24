require 'rails_helper'

RSpec.describe Billings::UpdateWorker, type: :worker do
  it 'updates the record' do
    billing = create(:billing, stripe_customer_id: 'customer_id')

    stub_request(:get, 'https://api.stripe.com/v1/products/product_id').to_return(
      status: 200,
      body: { metadata: { database_name: 'standard' } }.to_json
    )

    described_class.new.perform('customer_id', 'product_id', 'status', Time.current)

    expect(billing.reload.status).to eq('status')
    expect(billing.end_at).not_to eq(nil)
    expect(billing.product).to eq('standard')
  end
end
