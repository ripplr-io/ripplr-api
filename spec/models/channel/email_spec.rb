require 'rails_helper'

RSpec.describe Channel::Email, type: :model do
  subject(:channel_email) { build(:channel_email) }

  it { is_expected.to be_valid }

  it { is_expected.to have_one(:channel) }
  it { is_expected.to have_one(:user).through(:channel) }
end
