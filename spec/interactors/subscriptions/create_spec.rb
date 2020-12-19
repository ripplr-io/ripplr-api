require 'rails_helper'

RSpec.describe Subscriptions::Create, type: :interactor do
  it 'creates the subscription' do
    subscription = build(:subscription)

    expect { described_class.call(resource: subscription) }
      .to change { Subscription.count }.by(1)

    expect(Mixpanel::TrackSubscriptionCreatedWorker.jobs.size).to eq(1)
    expect(Prizes::Onboarding::FirstSubscriptionWorker.jobs.size).to eq(1)
  end

  context 'level limit reached' do
    it 'does not create the subscription' do
      level = create(:level, subscriptions: 2)
      user = create(:user, level: level)
      create_list(:subscription, 2, user: user)
      subscription = build(:subscription, user: user)

      expect { described_class.call(resource: subscription) }
        .to change { Subscription.count }.by(0)
    end
  end
end
