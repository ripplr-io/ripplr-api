require 'rails_helper'

RSpec.describe Hashtag, type: :model do
  subject { build(:hashtag) }

  it { is_expected.to be_valid }

  it_behaves_like :followable

  it { is_expected.to have_many(:post_hashtags) }
  it { is_expected.to have_many(:posts).through(:post_hashtags) }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_uniqueness_of(:name) }
end
