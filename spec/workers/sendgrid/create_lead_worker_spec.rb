require 'rails_helper'

RSpec.describe Sendgrid::CreateLeadWorker, type: :worker do
  it 'calls the sendgrid service' do
    expect_any_instance_of(Sendgrid::ContactService).to receive(:create_lead)

    described_class.new.perform('email@example.com')

    expect(Alerts::NewLeadWorker.jobs.size).to eq(1)
  end
end
