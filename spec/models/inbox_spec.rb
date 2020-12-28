require 'rails_helper'

RSpec.describe Inbox, type: :model do
  subject(:inbox) { build(:inbox) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to have_many(:subscription_inboxes) }
  it { is_expected.to have_many(:subscriptions).through(:subscription_inboxes) }
  it { is_expected.to have_many(:inbox_items) }
  it { is_expected.to have_many(:posts).through(:inbox_items).source(:inboxable) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:settings) }
end
