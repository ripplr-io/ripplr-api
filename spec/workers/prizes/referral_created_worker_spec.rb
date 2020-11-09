require 'rails_helper'

RSpec.describe Prizes::ReferralCreatedWorker, type: :worker do
  it 'creates a new prize' do
    referral = create(:referral)

    expect { described_class.new.perform(referral.id) }
      .to change { Prize.count }.by(1)

    new_prize = Prize.last
    expect(new_prize.name).to eq('Referral Created')
    expect(new_prize.points).to eq(10)
    expect(new_prize.prizable).to eq(referral)
    expect(new_prize.user).to eq(referral.inviter)
  end

  it 'is idempotent' do
    referral = create(:referral)

    expect { described_class.new.perform(referral.id) }
      .to change { Prize.count }.by(1)

    expect { described_class.new.perform(referral.id) }
      .to change { Prize.count }.by(0)
  end
end
