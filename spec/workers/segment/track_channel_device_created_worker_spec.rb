require 'rails_helper'

RSpec.describe Segment::TrackChannelDeviceCreatedWorker, type: :worker do
  it 'calls the service' do
    channel = create(:channel, :for_device)

    expect_any_instance_of(Segment::TrackService).to receive(:call).with(channel.user, 'Device Created')

    described_class.new.perform(channel.channel_device.id)
  end
end
