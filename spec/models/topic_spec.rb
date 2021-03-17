require 'rails_helper'

RSpec.describe Topic, type: :model do
  subject { build(:topic) }

  it { is_expected.to be_valid }

  it_behaves_like :followable

  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:community_topics) }
  it { is_expected.to have_many(:communities).through(:community_topics) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:avatar) }

  it { is_expected.to validate_uniqueness_of(:slug) }
end
