require 'rails_helper'

RSpec.describe Segment::TrackSubscriptionCreatedWorker, type: :worker do
  it 'calls the service' do
    subscription = create(:subscription)

    expect_any_instance_of(Segment::TrackService).to receive(:call).with(subscription.user, 'Subscription Created')

    described_class.new.perform(subscription.id)
  end
end
