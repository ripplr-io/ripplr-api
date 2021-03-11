require 'rails_helper'

RSpec.describe PostHashtag, type: :model do
  subject { build(:post_hashtag) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:hashtag) }

  it { is_expected.to validate_uniqueness_of(:hashtag_id).scoped_to(:post_id).case_insensitive }
end
