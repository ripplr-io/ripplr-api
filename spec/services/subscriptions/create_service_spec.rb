require 'rails_helper'

RSpec.describe Subscriptions::CreateService, type: :service do
  it 'creates the subscription' do
    subscribable = create(:user)

    subscription_params = {
      subscribable_id: subscribable.id,
      subscribable_type: 'User',
      settings: '{}',
      user: create(:user)
    }

    expect { described_class.new(subscription_params).save }
      .to change { Subscription.count }.by(1)

    expect(Mixpanel::TrackSubscriptionCreatedWorker.jobs.size).to eq(1)
  end

  context 'level limit reached' do
    it 'does not create the subscription' do
      level = create(:level, subscriptions: 2)
      user = create(:user, level: level)
      create_list(:subscription, 2, user: user)
      subscribable = create(:user)

      subscription_params = {
        subscribable_id: subscribable.id,
        subscribable_type: 'User',
        settings: '{}',
        user: user
      }

      expect { described_class.new(subscription_params).save }
        .to change { Subscription.count }.by(0)
    end
  end
end
