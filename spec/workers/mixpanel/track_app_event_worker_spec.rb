require 'rails_helper'

RSpec.describe Mixpanel::TrackAppEventWorker, type: :worker do
  it 'calls the mixpanel service' do
    user = create(:user)

    expect(Mixpanel::BaseService).to receive(:new).with(user.id).and_call_original
    expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with('Event Name', {})

    described_class.new.perform(user.id, 'Event Name')
  end
end
