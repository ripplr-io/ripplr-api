require 'rails_helper'

RSpec.describe :posts_create, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with not_found' do
      post posts_path
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
      user = create(:user)
      mock_post = build(:post, topic: create(:topic))

      post posts_path,
        params: mock_post.as_json(only: [:title, :body, :url, :topic_id]).merge(hashtags: ['hashtag'].to_json),
        headers: auth_headers_for(user)

      expect(response).to have_http_status(:created)
      expect(response_data).to have_resource(Post.last)
    end

    it 'sets the image from file' do
      image = fixture_file_upload('logo.png', 'image/png')
      user = create(:user)
      mock_post = build(:post, topic: create(:topic))

      post posts_path,
        params: mock_post.as_json(only: [:title, :body, :url, :topic_id]).merge(image_file: image),
        headers: auth_headers_for(user)

      expect(Post.last.image.present?).to eq true
    end

    it 'responds with errors' do
      user = create(:user)

      post posts_path, headers: auth_headers_for(user)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:title)
      expect(response_errors).to have_error(:body)
      expect(response_errors).to have_error(:url)
      expect(response_errors).to have_error(:topic)
    end
  end
end
