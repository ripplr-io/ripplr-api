require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it { is_expected.to be_valid }

  it_behaves_like :followable
  it_behaves_like :subscribable

  it { is_expected.to belong_to(:level) }
  it { is_expected.to have_one(:billing) }

  it { is_expected.to have_many(:content_sources) }
  it { is_expected.to have_many(:comments).inverse_of(:author).with_foreign_key(:author_id) }
  it { is_expected.to have_many(:devices) }
  it { is_expected.to have_many(:notifications) }
  it { is_expected.to have_many(:posts).inverse_of(:author).with_foreign_key(:author_id) }
  it { is_expected.to have_many(:prizes) }
  it { is_expected.to have_many(:tickets) }
  it { is_expected.to have_many(:ratings) }
  it { is_expected.to have_many(:received_ratings).through(:posts).source(:ratings) }
  it { is_expected.to have_many(:follows) }
  it { is_expected.to have_many(:following_hashtags).through(:follows).source(:followable) }
  it { is_expected.to have_many(:following_topics).through(:follows).source(:followable) }
  it { is_expected.to have_many(:following_users).through(:follows).source(:followable) }
  it { is_expected.to have_many(:following_hashtag_posts).through(:following_hashtags).source(:posts) }
  it { is_expected.to have_many(:following_topic_posts).through(:following_topics).source(:posts) }
  it { is_expected.to have_many(:following_user_posts).through(:following_users).source(:posts) }
  it { is_expected.to have_many(:subscriptions) }
  it { is_expected.to have_many(:subscribing_users).through(:subscriptions).source(:user) }
  it { is_expected.to have_many(:push_notifications).through(:subscriptions) }
  it { is_expected.to have_many(:push_notification_posts).through(:push_notifications).source(:post) }
  it { is_expected.to have_many(:inboxes) }
  it { is_expected.to have_many(:bookmark_folders) }
  it { is_expected.to have_many(:bookmarks) }
  it { is_expected.to have_many(:referrals).inverse_of(:inviter).with_foreign_key(:inviter_id) }
  it { is_expected.to have_many(:referred_users).through(:referrals).source(:invitee) }

  it { is_expected.to have_one(:referral).inverse_of(:invitee).with_foreign_key(:invitee_id) }
  it { is_expected.to have_one(:referee).through(:referral).source(:inviter) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:timezone) }
  it { should allow_value([true, false]).for(:subscribed_to_marketing) }

  it { is_expected.to validate_uniqueness_of(:slug) }
end
