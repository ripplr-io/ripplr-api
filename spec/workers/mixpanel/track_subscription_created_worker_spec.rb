require 'rails_helper'

RSpec.describe Mixpanel::TrackSubscriptionCreatedWorker, type: :worker do
  it 'calls the mixpanel service' do
    subscription = create(:subscription)

    expect(Mixpanel::BaseService).to receive(:new).with(subscription.user.id).and_call_original
    expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with('Subscription Created')

    described_class.new.perform(subscription.id)
  end
end
