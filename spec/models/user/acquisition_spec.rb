require 'rails_helper'

RSpec.describe User::Acquisition, type: :model do
  subject { build(:user_acquisition) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:user) }
end
