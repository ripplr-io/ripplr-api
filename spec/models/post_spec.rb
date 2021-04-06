require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { build(:post) }

  it { is_expected.to be_valid }

  it_behaves_like :inboxable
  it_behaves_like :ratable

  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:author) }

  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:post_hashtags) }
  it { is_expected.to have_many(:hashtags).through(:post_hashtags) }
  it { is_expected.to have_many(:bookmarks) }
  it { is_expected.to have_many(:topic_followers).through(:topic).source(:followers) }
  it { is_expected.to have_many(:author_followers).through(:author).source(:followers) }
  it { is_expected.to have_many(:hashtag_followers).through(:hashtags).source(:followers) }
  it { is_expected.to have_many(:community_followers).through(:communities).source(:followers) }
  it { is_expected.to have_many(:subscriptions).through(:author).source(:received_subscriptions) }
  it { is_expected.to have_many(:candidate_inboxes).through(:subscriptions).source(:inboxes) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_presence_of(:body) }

  context 'creation' do
    subject { create(:post) }

    it { is_expected.to validate_uniqueness_of(:slug) }
  end
end
