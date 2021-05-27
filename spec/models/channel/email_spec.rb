require 'rails_helper'

RSpec.describe Channel::Email, type: :model do
  subject { build(:channel_email) }

  it_behaves_like :channelable

  it { is_expected.to be_valid }
  it { is_expected.to have_one(:user).through(:channel) }
end
