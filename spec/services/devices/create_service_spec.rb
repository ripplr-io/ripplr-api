require 'rails_helper'

RSpec.describe Devices::CreateService, type: :service do
  it 'creates the device' do
    device = build(:device)

    expect { described_class.new(device).save }
      .to change { Device.count }.by(1)

    expect(Mixpanel::TrackDeviceCreatedWorker.jobs.size).to eq 1
    expect(Prizes::Onboarding::FirstDeviceWorker.jobs.size).to eq(1)
  end
end
