require 'rails_helper'

RSpec.describe Channel, type: :model do
  subject { build(:channel) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:channelable) }

  it { is_expected.to have_many(:inbox_channels) }
  it { is_expected.to have_many(:inboxes).through(:inbox_channels) }

  xit { is_expected.to validate_presence_of(:settings) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }
end
