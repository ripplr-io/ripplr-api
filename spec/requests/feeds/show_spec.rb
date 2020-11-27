require 'rails_helper'

RSpec.describe :feeds_show, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with not_found' do
      get feed_path
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user is authenticated' do
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
  end
end
