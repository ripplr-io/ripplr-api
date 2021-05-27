require 'rails_helper'

RSpec.describe Notification::NewLevel, type: :model do
  subject { build(:notification_new_level) }

  it_behaves_like :notifiable

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:level) }
  it { is_expected.to have_one(:user).through(:notification) }
end
