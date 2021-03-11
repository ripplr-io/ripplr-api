require 'rails_helper'

RSpec.describe Level, type: :model do
  subject { build(:level) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:from) }
  it { is_expected.to validate_presence_of(:to) }
  it { is_expected.to validate_presence_of(:posts) }
  it { is_expected.to validate_presence_of(:referrals) }
  it { is_expected.to validate_presence_of(:subscriptions) }
end
