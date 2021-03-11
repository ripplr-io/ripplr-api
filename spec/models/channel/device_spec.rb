require 'rails_helper'

RSpec.describe Channel::Device, type: :model do
  subject { build(:channel_device) }

  it { is_expected.to be_valid }

  it { is_expected.to have_one(:channel) }

  it { is_expected.to validate_presence_of(:onesignal_id) }
end
