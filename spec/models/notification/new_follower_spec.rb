require 'rails_helper'

RSpec.describe Notification::NewFollower, type: :model do
  subject { build(:notification_new_follower) }

  it_behaves_like :notifiable

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:follow) }
  it { is_expected.to have_one(:follower).through(:follow).source(:user) }
end
