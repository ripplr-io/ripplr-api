require 'rails_helper'

RSpec.describe CommunityPost, type: :model do
  subject(:community_post) { build(:community_post) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:community) }
  it { is_expected.to belong_to(:post) }

  it { is_expected.to validate_uniqueness_of(:post_id).scoped_to(:community_id).case_insensitive }
end
