require 'rails_helper'

RSpec.describe Devices::CreateService, type: :service do
  it 'creates the device' do
    device_params = {
      name: 'Name',
      user: create(:user),
      device_type: 'Computer',
      settings: '{}',
      onesignal_id: 'test_onesignal_id'
    }

    expect { described_class.new(device_params).save }
      .to change { Device.count }.by(1)

    expect(Mixpanel::TrackDeviceCreatedWorker.jobs.size).to eq 1
  end
end
