require 'rails_helper'

RSpec.describe Segment::TrackReferralCreatedWorker, type: :worker do
  it 'calls the service' do
    referral = create(:referral)

    expect_any_instance_of(Segment::TrackService).to receive(:call).with(referral.inviter, 'Referral Created')

    described_class.new.perform(referral.id)
  end
end
