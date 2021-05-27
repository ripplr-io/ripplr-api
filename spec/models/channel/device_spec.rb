require 'rails_helper'

RSpec.describe Channel::Device, type: :model do
  subject { build(:channel_device) }

  it_behaves_like :channelable

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:onesignal_id) }
end
