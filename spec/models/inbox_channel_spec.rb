require 'rails_helper'

RSpec.describe InboxChannel, type: :model do
  subject(:inbox_channel) { build(:inbox_channel) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:channel) }
  it { is_expected.to belong_to(:inbox) }

  it { is_expected.to validate_uniqueness_of(:inbox_id).scoped_to(:channel_id).case_insensitive }
end
