require 'rails_helper'

RSpec.describe InboxItem, type: :model do
  subject { build(:inbox_item) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:inboxable) }
  it { is_expected.to belong_to(:inbox) }

  it { is_expected.to have_many(:inbox_notifications) }

  it { is_expected.to validate_uniqueness_of(:inboxable_id).scoped_to([:inboxable_type, :inbox_id]).case_insensitive }
end
