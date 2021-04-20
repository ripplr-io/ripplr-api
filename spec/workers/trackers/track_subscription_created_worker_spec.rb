require 'rails_helper'

RSpec.describe Trackers::TrackSubscriptionCreatedWorker, type: :worker do
  it 'calls the service' do
    subscription = create(:subscription)

    expect(Analytics).to receive(:track).with(subscription.user, 'Subscription Created')

    described_class.new.perform(subscription.id)
  end
end
