require 'rails_helper'

RSpec.describe Prizes::Onboarding::CompletedBonusWorker, type: :worker do
  context 'the user has no onboarding prizes' do
    it 'does not create a new prize' do
      user = create(:user)

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(0)
    end
  end

  context 'the user has some onboarding prizes' do
    it 'does not create a new prize' do
      user = create(:user)
      create(:prize, user: user, name: 'First Follow')
      create(:prize, user: user, name: 'First Device')
      create(:prize, user: user, name: 'First Post')

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(0)
    end
  end

  context 'the user has all the onboarding prizes' do
    it 'creates a new prize' do
      user = create(:user)
      names = ['First Follow', 'First Rating', 'First Device', 'First Post', 'First Subscription', 'First Referral']
      names.each { |name| create(:prize, user: user, name: name) }

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(1)

      new_prize = Prize.last
      expect(new_prize.name).to eq('Onboarding Completed Bonus')
      expect(new_prize.points).to eq(200)
      expect(new_prize.prizable).to eq(nil)
      expect(new_prize.user).to eq(user)
      expect(Account::BroadcastChangesWorker.jobs.size).to eq(1)
    end

    it 'is idempotent' do
      user = create(:user)
      names = ['First Follow', 'First Rating', 'First Device', 'First Post', 'First Subscription', 'First Referral']
      names.each { |name| create(:prize, user: user, name: name) }

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(1)

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(0)
    end
  end
end
