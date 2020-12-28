require 'rails_helper'

RSpec.describe Inbox::Item, type: :model do
  subject(:inbox_item) { build(:inbox_item) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:inboxable) }
  it { is_expected.to belong_to(:inbox) }
end
