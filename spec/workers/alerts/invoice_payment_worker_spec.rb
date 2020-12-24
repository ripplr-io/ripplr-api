require 'rails_helper'

RSpec.describe Alerts::InvoicePaymentWorker, type: :worker do
  it 'calls the slack service' do
    expect_any_instance_of(Slack::NotifyService).to receive(:ping)

    described_class.new.perform('customer_id', 'true', 'intent_id')
  end
end
