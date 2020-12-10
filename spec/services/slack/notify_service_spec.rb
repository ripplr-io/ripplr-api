require 'rails_helper'

RSpec.describe Slack::NotifyService, type: :service do
  it 'sends a message to a channel' do
    instance = described_class.new
    expect(instance.instance_variable_get(:@notifier)).to receive(:ping)

    instance.ping('message', '#channel')
  end
end
