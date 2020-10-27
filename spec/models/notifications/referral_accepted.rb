require 'rails_helper'

RSpec.describe Notifications::ReferralAccepted, type: :model do
  subject(:referral_accepted) { build(:referral_accepted) }

  it { is_expected.to be_valid }

  it_behaves_like :notification
end
