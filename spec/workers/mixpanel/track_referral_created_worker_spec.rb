require 'rails_helper'

RSpec.describe Mixpanel::TrackReferralCreatedWorker, type: :worker do
  it 'calls the mixpanel service' do
    referral = create(:referral)

    expect(Mixpanel::BaseService).to receive(:new).with(referral.inviter.id).and_call_original
    expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with('Referral Created')

    described_class.new.perform(referral.id)
  end
end
