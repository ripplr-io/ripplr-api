require 'rails_helper'

RSpec.describe Subscriptions::Create, type: :interactor do
  it 'creates the subscription' do
    subscription = build(:subscription)

    expect { described_class.call(resource: subscription) }
      .to change { Subscription.count }.by(1)

    expect(Trackers::TrackSubscriptionCreatedWorker.jobs.size).to eq(1)
    expect(Prizes::Onboarding::FirstSubscriptionWorker.jobs.size).to eq(1)
  end
end
