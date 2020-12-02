require 'rails_helper'

RSpec.describe Prizes::Onboarding::FirstSubscriptionWorker, type: :worker do
  context 'the user has no subscriptions' do
    it 'does not create a new prize' do
      user = create(:user)

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(0)
    end
  end

  context 'the user has subscriptions' do
    it 'creates a new prize' do
      user = create(:user)
      create(:subscription, user: user)

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(1)

      new_prize = Prize.last
      expect(new_prize.name).to eq('First Subscription')
      expect(new_prize.points).to eq(150)
      expect(new_prize.prizable).to eq(nil)
      expect(new_prize.user).to eq(user)
    end

    it 'is idempotent' do
      user = create(:user)
      create(:subscription, user: user)

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(1)

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(0)
    end
  end
end
