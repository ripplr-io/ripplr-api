require 'rails_helper'

RSpec.describe Notification::AcceptedReferral, type: :model do
  subject { build(:notification_accepted_referral) }

  it_behaves_like :notifiable

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:referral) }
  it { is_expected.to have_one(:invitee).through(:referral) }
end
