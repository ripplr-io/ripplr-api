require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject { build(:profile) }

  it { is_expected.to be_valid }

  it_behaves_like :followable
  it_behaves_like :subscribable

  it { is_expected.to belong_to(:profilable) }

  it { is_expected.to validate_presence_of(:name) }

  context 'creation' do
    subject { create(:profile) }

    it { is_expected.to validate_uniqueness_of(:slug) }
  end
end
