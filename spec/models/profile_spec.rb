require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject { build(:profile) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:profilable) }

  it { is_expected.to validate_presence_of(:name) }

  context 'creation' do
    subject { create(:user).profile }

    it { is_expected.to validate_uniqueness_of(:slug) }
  end
end
