require 'rails_helper'

RSpec.describe CommunityTopic, type: :model do
  subject { build(:community_topic) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:community) }
  it { is_expected.to belong_to(:topic) }

  it { is_expected.to validate_uniqueness_of(:topic_id).scoped_to(:community_id).case_insensitive }
end
