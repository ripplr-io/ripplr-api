require 'rails_helper'

RSpec.describe Prize, type: :model do
  subject(:prize) { build(:prize) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:prizable) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:points) }
end