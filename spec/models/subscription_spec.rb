require 'rails_helper'

RSpec.describe Subscription, type: :model do
  subject(:subscription) { build(:subscription) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:subscribable) }

  it { is_expected.to have_many(:push_notifications) }

  it { is_expected.to validate_presence_of(:settings) }
  it do
    is_expected.to validate_uniqueness_of(:subscribable_id).scoped_to([:subscribable_type, :user_id]).case_insensitive
  end
end
