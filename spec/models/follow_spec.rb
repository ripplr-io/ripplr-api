require 'rails_helper'

RSpec.describe Follow, type: :model do
  subject(:follow) { build(:follow) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:followable) }
end
