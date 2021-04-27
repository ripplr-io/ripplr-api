require 'rails_helper'

RSpec.describe Posts::BroadcastCreationWorker, type: :worker do
  it 'broadcasts to the channels' do
    post = create(:post)
    post_hashtag = create(:post_hashtag, post: post)
    community_post = create(:community_post, post: post)
    follow = create(:follow, followable: post.topic)

    expect { described_class.new.perform(post.id) }
      .to have_broadcasted_to(post.topic).from_channel(TopicChannel)
      .and have_broadcasted_to(post.author).from_channel(ProfileChannel)
      .and have_broadcasted_to(post_hashtag.hashtag).from_channel(HashtagChannel)
      .and have_broadcasted_to(community_post.community).from_channel(CommunityChannel)
      .and have_broadcasted_to(follow.user).from_channel(UserChannel)
  end
end
