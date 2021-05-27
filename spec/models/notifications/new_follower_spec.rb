require 'rails_helper'

RSpec.describe Notifications::NewFollower, type: :model do
  subject { build(:new_follower) }

  it_behaves_like :notification

  it { is_expected.to be_valid }
end
