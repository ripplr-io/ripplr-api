require 'rails_helper'

RSpec.describe :posts_index, type: :request do
  it 'responds with the user resources' do
    profile = create(:profile)
    profile_post = create(:post, author: profile)
    other_post = create(:post)

    get user_posts_path(profile)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(profile_post)
    expect(response_data).not_to have_resource(other_post)
  end

  it 'responds with the topic resources' do
    topic = create(:topic)
    topic_post = create(:post, topic: topic)
    other_post = create(:post)

    get topic_posts_path(topic)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(topic_post)
    expect(response_data).not_to have_resource(other_post)
  end

  it 'responds with the hashtag resources' do
    post_hashtag = create(:post_hashtag)
    other_post = create(:post)

    get hashtag_posts_path(hashtag_id: post_hashtag.hashtag.name)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(post_hashtag.post)
    expect(response_data).not_to have_resource(other_post)
  end

  it 'responds with the community resources' do
    community_post = create(:community_post)
    other_post = create(:post)

    get community_posts_path(community_post.community)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(community_post.post)
    expect(response_data).not_to have_resource(other_post)
  end

  it 'reponds with included associations' do
    user = create(:user)
    post_hashtag = create(:post_hashtag)
    post = post_hashtag.post
    bookmark = create(:bookmark, post: post, user: user)

    get hashtag_posts_path(hashtag_id: post_hashtag.hashtag.name), headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_included).to have_resource(post.author)
    expect(response_included).to have_resource(post.topic)
    expect(response_included).to have_resource(post.hashtags.first)
    expect(response_included).to have_resource(bookmark)
  end

  context 'order' do
    context 'sort_by is blank' do
      it 'orders chronologically' do
        topic = create(:topic)
        old_post = create(:post, topic: topic, created_at: Time.current - 1.day)
        new_post = create(:post, topic: topic, created_at: Time.current)

        get topic_posts_path(topic)

        expect(response).to have_http_status(:ok)
        expect(response_data.first).to be_resource(new_post)
        expect(response_data.second).to be_resource(old_post)
      end
    end

    context 'sort_by eq created_at' do
      it 'orders chronologically' do
        topic = create(:topic)
        old_post = create(:post, topic: topic, created_at: Time.current - 1.day)
        new_post = create(:post, topic: topic, created_at: Time.current)

        get topic_posts_path(topic), params: { sort_by: :created_at }

        expect(response).to have_http_status(:ok)
        expect(response_data.first).to be_resource(new_post)
        expect(response_data.second).to be_resource(old_post)
      end
    end

    context 'sort_by eq rating' do
      it 'orders by rating' do
        topic = create(:topic)
        popular_post = create(:post, topic: topic, ratings_points_total: 100)
        unpopular_post = create(:post, topic: topic, ratings_points_total: 10)

        get topic_posts_path(topic), params: { sort_by: :rating }

        expect(response).to have_http_status(:ok)
        expect(response_data.first).to be_resource(popular_post)
        expect(response_data.second).to be_resource(unpopular_post)
      end
    end

    context 'sort_by eq popularity' do
      it 'orders by trending' do
        topic = create(:topic)
        trending_post = create(:post, topic: topic, trending_score: 100)
        other_post = create(:post, topic: topic, trending_score: 10)

        get topic_posts_path(topic), params: { sort_by: :popularity }

        expect(response).to have_http_status(:ok)
        expect(response_data.first).to be_resource(trending_post)
        expect(response_data.second).to be_resource(other_post)
      end
    end
  end
end
