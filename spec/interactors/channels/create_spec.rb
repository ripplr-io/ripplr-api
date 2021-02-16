require 'rails_helper'

RSpec.describe Channels::Create, type: :interactor do
  it 'creates the channel' do
    channel = build(:channel)

    expect { described_class.call(resource: channel) }
      .to change { Channel.count }.by(1)
  end

  context 'with email' do
    it 'creates the channel email' do
      channel = build(:channel, :for_email)

      expect { described_class.call(resource: channel) }
        .to change { Channel::Email.count }.by(1)

      expect(Mixpanel::TrackChannelDeviceCreatedWorker.jobs.size).to eq(0)
      expect(Prizes::Onboarding::FirstDeviceWorker.jobs.size).to eq(0)
    end
  end

  context 'with device' do
    it 'creates the channel device' do
      channel = build(:channel, :for_device)

      expect { described_class.call(resource: channel) }
        .to change { Channel::Device.count }.by(1)

      expect(Mixpanel::TrackChannelDeviceCreatedWorker.jobs.size).to eq(1)
      expect(Prizes::Onboarding::FirstDeviceWorker.jobs.size).to eq(1)
    end
  end
end
