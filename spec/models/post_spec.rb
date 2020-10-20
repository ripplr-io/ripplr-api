require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:post) { build(:post) }

  it { is_expected.to be_valid }

  it_behaves_like :ratable

  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:author) }

  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:post_hashtags) }
  it { is_expected.to have_many(:hashtags).through(:post_hashtags) }
  it { is_expected.to have_many(:push_notifications) }
  it { is_expected.to have_many(:received_subscriptions) }
  it { is_expected.to have_many(:bookmarks) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:image) }
end