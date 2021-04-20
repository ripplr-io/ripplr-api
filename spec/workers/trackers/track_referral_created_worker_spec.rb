require 'rails_helper'

RSpec.describe Trackers::TrackReferralCreatedWorker, type: :worker do
  it 'calls the service' do
    referral = create(:referral)

    expect(Analytics).to receive(:track).with(referral.inviter, 'Referral Created')

    described_class.new.perform(referral.id)
  end
end
