require 'rails_helper'

RSpec.describe Referral, type: :model do
  subject { build(:referral) }

  it_behaves_like :prizable

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:inviter) }
  it { is_expected.to belong_to(:invitee).optional }

  it { is_expected.to have_many(:notification_accepted_referrals) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).scoped_to(:inviter_id).case_insensitive }
  xit { is_expected.to validate_uniqueness_of(:invitee_id).scoped_to(:inviter_id) }

  it { is_expected.to allow_value('user@ripplr.io').for(:email) }
  it { is_expected.not_to allow_value('ripplr.io').for(:email) }
end
