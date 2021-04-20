require 'rails_helper'

RSpec.describe Trackers::TrackAppEventWorker, type: :worker do
  it 'calls the service' do
    user = create(:user)

    expect(Analytics).to receive(:track).with(user, 'Event Name', {})

    described_class.new.perform(user.id, 'Event Name')
  end
end
