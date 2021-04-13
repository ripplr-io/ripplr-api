require 'rails_helper'

RSpec.describe Segment::TrackAppEventWorker, type: :worker do
  it 'calls the service' do
    user = create(:user)

    expect_any_instance_of(Segment::TrackService).to receive(:call).with(user, 'Event Name', {})

    described_class.new.perform(user.id, 'Event Name')
  end
end
