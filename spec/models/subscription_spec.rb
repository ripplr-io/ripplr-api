require 'rails_helper'

RSpec.describe Subscription, type: :model do
  subject(:subscription) { build(:subscription) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:subscribable) }

  it { is_expected.to have_many(:push_notifications) }

  it { is_expected.to validate_presence_of(:settings) }
end
