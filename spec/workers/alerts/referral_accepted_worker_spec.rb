require 'rails_helper'

RSpec.describe Alerts::ReferralAcceptedWorker, type: :worker do
  it 'calls the slack service' do
    referral = create(:referral, invitee: create(:user))

    expect_any_instance_of(Slack::NotifyService).to receive(:ping)

    described_class.new.perform(referral.id)
  end
end
