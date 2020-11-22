require 'rails_helper'

RSpec.describe Mixpanel::TrackDeviceCreatedWorker, type: :worker do
  it 'calls the mixpanel service' do
    device = create(:device)

    expect(Mixpanel::BaseService).to receive(:new).with(device.user.id).and_call_original
    expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with('Device Created')

    described_class.new.perform(device.id)
  end
end
