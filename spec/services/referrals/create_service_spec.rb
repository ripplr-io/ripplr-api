require 'rails_helper'

RSpec.describe Referrals::CreateService, type: :service do
  it 'creates the referral' do
    referral_params = {
      name: 'Name',
      email: 'example@ripplr.io',
      inviter: create(:user)
    }

    expect { described_class.new(referral_params).save }
      .to change { Referral.count }.by(1)

    # FIXME: verify params
    expect(Sidekiq::Worker.jobs.size).to eq 1
  end
end
