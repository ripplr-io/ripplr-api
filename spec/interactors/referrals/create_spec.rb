require 'rails_helper'

RSpec.describe Referrals::Create, type: :interactor do
  it 'creates the referral' do
    referral = build(:referral)

    expect { described_class.call(resource: referral) }
      .to change { Referral.count }.by(1)

    expect(Sidekiq::Queues['mailers'].size).to eq 1
    expect(Prizes::ReferralCreatedWorker.jobs.size).to eq(1)
    expect(Mixpanel::TrackReferralCreatedWorker.jobs.size).to eq(1)
    expect(Alerts::ReferralCreatedWorker.jobs.size).to eq(1)
  end

  context 'level limit reached' do
    it 'does not create the referral' do
      level = create(:level, referrals: 2)
      user = create(:user, level: level)
      create_list(:referral, 2, inviter: user)

      referral = build(:referral, inviter: user)

      expect { described_class.call(resource: referral) }
        .to change { Referral.count }.by(0)
    end
  end
end
