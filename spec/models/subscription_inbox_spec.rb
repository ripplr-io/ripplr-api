require 'rails_helper'

RSpec.describe SubscriptionInbox, type: :model do
  subject { build(:subscription_inbox) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:subscription) }
  it { is_expected.to belong_to(:inbox) }
end
