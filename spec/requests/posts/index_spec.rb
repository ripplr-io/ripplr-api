require 'rails_helper'

RSpec.describe :posts_index, type: :request do
  it 'responds with the user resources' do
    user = create(:user)
    user_post = create(:post, author: user)
    other_post = create(:post)

    get user_posts_path(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(user_post)
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
end
