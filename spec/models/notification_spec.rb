require 'rails_helper'

RSpec.describe Notification, type: :model do
  subject { build(:notification) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:notifiable) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_one(:profile) }
end
