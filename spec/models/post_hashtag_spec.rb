require 'rails_helper'

RSpec.describe PostHashtag, type: :model do
  subject(:post_hashtag) { build(:post_hashtag) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:hashtag) }
end