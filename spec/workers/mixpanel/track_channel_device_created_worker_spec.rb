require 'rails_helper'

RSpec.describe Mixpanel::TrackChannelDeviceCreatedWorker, type: :worker do
  it 'calls the mixpanel service' do
    channel_device = create(:channel_device)

    expect(Mixpanel::BaseService).to receive(:new).with(channel_device.channel.user).and_call_original
    expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with('Device Created')

    described_class.new.perform(channel_device.id)
  end
end
