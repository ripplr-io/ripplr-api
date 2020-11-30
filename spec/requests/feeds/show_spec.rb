require 'rails_helper'

RSpec.describe :feeds_show, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { get feed_path }
  end

  it 'responds with the user resources' do
    user = create(:user)

    user_follow = create(:follow, :for_user, user: user)
    topic_follow = create(:follow, :for_topic, user: user)
    hashtag_follow = create(:follow, :for_hashtag, user: user)

    followed_user_post = create(:post, author: user_follow.followable)
    followed_topic_post = create(:post, topic: topic_follow.followable)
    followed_post_hashtag = create(:post_hashtag, hashtag: hashtag_follow.followable)

    other_post_a = create(:post)
    other_post_b = create(:post)

    get feed_path, headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(followed_user_post)
    expect(response_data).to have_resource(followed_topic_post)
    expect(response_data).to have_resource(followed_post_hashtag.post)
    expect(response_data).not_to have_resource(other_post_a)
    expect(response_data).not_to have_resource(other_post_b)
  end

  it 'reponds with included associations' do
    user = create(:user)
    follow = create(:follow, :for_hashtag, user: user)
    post_hashtag = create(:post_hashtag, hashtag: follow.followable)
    post = post_hashtag.post
    bookmark = create(:bookmark, post: post, user: user)

    get feed_path, headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_included).to have_resource(post.author)
    expect(response_included).to have_resource(post.topic)
    expect(response_included).to have_resource(post.hashtags.first)
    expect(response_included).to have_resource(bookmark)
  end
end
