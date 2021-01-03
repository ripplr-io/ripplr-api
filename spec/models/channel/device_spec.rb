require 'rails_helper'

RSpec.describe Channel::Device, type: :model do
  subject(:channel_device) { build(:channel_device) }

  it { is_expected.to be_valid }

  it { is_expected.to define_enum_for(:device_type).backed_by_column_of_type(:string) }

  it { is_expected.to have_one(:channel) }

  it { is_expected.to validate_presence_of(:device_type) }
  it { is_expected.to validate_presence_of(:onesignal_id) }
end
