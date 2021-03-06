require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it_behaves_like :profilable

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:level) }
  it { is_expected.to have_one(:billing) }

  it { is_expected.to have_many(:content_sources) }
  it { is_expected.to have_many(:communities).inverse_of(:owner).with_foreign_key(:owner_id) }
  it { is_expected.to have_many(:notifications) }
  it { is_expected.to have_many(:prizes) }
  it { is_expected.to have_many(:tickets) }
  it { is_expected.to have_many(:channels) }
  it { is_expected.to have_many(:channel_devices).through(:channels).source(:channelable) }
  it { is_expected.to have_many(:channel_emails).through(:channels).source(:channelable) }
  it { is_expected.to have_many(:ratings) }
  it { is_expected.to have_many(:profile_posts).through(:profile).source(:posts) }
  it { is_expected.to have_many(:received_ratings).through(:profile_posts).source(:ratings) }

  it { is_expected.to have_many(:follows) }
  it { is_expected.to have_many(:following_hashtags).through(:follows).source(:followable) }
  it { is_expected.to have_many(:following_topics).through(:follows).source(:followable) }
  it { is_expected.to have_many(:following_communities).through(:follows).source(:followable) }
  it { is_expected.to have_many(:following_profiles).through(:follows).source(:followable) }

  it { is_expected.to have_many(:following_hashtag_posts).through(:following_hashtags).source(:posts) }
  it { is_expected.to have_many(:following_topic_posts).through(:following_topics).source(:posts) }
  it { is_expected.to have_many(:following_community_posts).through(:following_communities).source(:posts) }
  it { is_expected.to have_many(:following_profile_posts).through(:following_profiles).source(:posts) }

  it { is_expected.to have_many(:subscriptions) }
  it { is_expected.to have_many(:subscribing_users).through(:subscriptions).source(:user) }
  it { is_expected.to have_many(:inboxes) }
  it { is_expected.to have_many(:bookmark_folders) }
  it { is_expected.to have_many(:bookmarks) }
  it { is_expected.to have_many(:referrals).inverse_of(:inviter).with_foreign_key(:inviter_id) }
  it { is_expected.to have_many(:referred_users).through(:referrals).source(:invitee) }

  it { is_expected.to have_one(:referral).inverse_of(:invitee).with_foreign_key(:invitee_id) }
  it { is_expected.to have_one(:referee).through(:referral).source(:inviter) }

  it { is_expected.to validate_presence_of(:timezone) }
  it { should allow_value([true, false]).for(:subscribed_to_marketing) }
end
