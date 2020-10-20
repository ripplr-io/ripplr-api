require 'rails_helper'

RSpec.describe Referral, type: :model do
  subject(:referral) { build(:referral) }

  it { is_expected.to be_valid }

  it_behaves_like :prizable

  it { is_expected.to belong_to(:inviter) }
  it { is_expected.to belong_to(:invitee).optional }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
end