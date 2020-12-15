require 'rails_helper'

RSpec.describe Prizes::Onboarding::FirstReferralWorker, type: :worker do
  context 'the user has no referrals' do
    it 'does not create a new prize' do
      user = create(:user)

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(0)
    end
  end

  context 'the user has no accepted referrals' do
    it 'does not create a new prize' do
      user = create(:user)
      create(:referral, inviter: user)

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(0)
    end
  end

  context 'the user has accepted referrals' do
    it 'creates a new prize' do
      user = create(:user)
      create(:referral, inviter: user, invitee: create(:user))

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(1)

      new_prize = Prize.last
      expect(new_prize.name).to eq('First Referral')
      expect(new_prize.points).to eq(150)
      expect(new_prize.prizable).to eq(nil)
      expect(new_prize.user).to eq(user)
      expect(Account::BroadcastChangesWorker.jobs.size).to eq(1)
    end

    it 'is idempotent' do
      user = create(:user)
      create(:referral, inviter: user, invitee: create(:user))

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(1)

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(0)
    end
  end
end
