require 'rails_helper'

RSpec.describe InboxNotification, type: :model do
  subject(:inbox_notification) { build(:inbox_notification) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:inbox_item) }
  it { is_expected.to belong_to(:inbox_channel) }

  it { is_expected.to have_one(:channel).through(:inbox_channel) }
  it { is_expected.to have_one(:inbox).through(:inbox_channel) }

  it { is_expected.to validate_uniqueness_of(:inbox_item_id).scoped_to(:inbox_channel_id).case_insensitive }
end
