require 'rails_helper'

RSpec.describe Trackers::TrackChannelDeviceCreatedWorker, type: :worker do
  it 'calls the service' do
    channel = create(:channel, :for_device)

    expect(Analytics).to receive(:track).with(channel.user, 'Device Created')

    described_class.new.perform(channel.channel_device.id)
  end
end
