require 'rails_helper'

RSpec.describe Rating, type: :model do
  subject(:rating) { build(:rating) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:ratable) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:points) }
  it { is_expected.to validate_inclusion_of(:points).in_array([0, 1, 3, 5, 8]) }
end