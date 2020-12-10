require 'rails_helper'

RSpec.describe Alerts::NewLeadWorker, type: :worker do
  it 'calls the slack service' do
    expect_any_instance_of(Slack::NotifyService).to receive(:ping)

    described_class.new.perform('email@example.com')
  end
end
