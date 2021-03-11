require 'rails_helper'

RSpec.describe Community, type: :model do
  subject { build(:community) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:owner) }

  it { is_expected.to have_many(:community_topics) }
  it { is_expected.to have_many(:topics).through(:community_topics) }
  it { is_expected.to have_many(:community_posts) }
  it { is_expected.to have_many(:posts).through(:community_posts) }

  it { is_expected.to validate_presence_of(:community_topics) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }

  it { is_expected.to validate_length_of(:name).is_at_most(20) }
  it { is_expected.to validate_length_of(:description).is_at_most(500) }

  it { is_expected.to validate_uniqueness_of(:slug) }
end
