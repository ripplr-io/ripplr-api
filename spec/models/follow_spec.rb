require 'rails_helper'

RSpec.describe Follow, type: :model do
  subject(:follow) { build(:follow) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:followable) }

  it { is_expected.to validate_uniqueness_of(:followable_id).scoped_to([:followable_type, :user_id]).case_insensitive }
end
