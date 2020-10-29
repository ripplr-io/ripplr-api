require 'rails_helper'

RSpec.describe Notifications::NewFollower, type: :model do
  subject(:new_follower) { build(:new_follower) }

  it { is_expected.to be_valid }

  it_behaves_like :notification
end