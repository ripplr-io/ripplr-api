require 'rails_helper'

RSpec.describe :posts_create, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      post posts_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
      user = create(:user)
      mock_post = build(:post, topic: create(:topic))

      post posts_path,
        params: mock_post.as_json(only: [:title, :body, :image, :url, :topic_id]).merge!({ hashtags: ['hashtag'] }),
        headers: auth_headers_for(user)

      expect(response).to have_http_status(:created)
      expect(response_data).to have_resource(Post.last)
    end

    it 'responds with errors' do
      user = create(:user)

      post posts_path, headers: auth_headers_for(user)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:title)
      expect(response_errors).to have_error(:body)
      expect(response_errors).to have_error(:image)
      expect(response_errors).to have_error(:url)
      expect(response_errors).to have_error(:topic)
    end
  end
end
