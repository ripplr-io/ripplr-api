require 'rails_helper'

RSpec.describe :posts_update, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with not_found' do
      patch post_path(0)
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user does not own the resource' do
    it 'responds with not found' do
      user = create(:user)
      mock_post = create(:post)

      patch post_path(mock_post), headers: auth_headers_for(user)

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user owns the resource' do
    it 'responds with the resource' do
      user = create(:user)
      mock_post = create(:post, author: user)

      patch post_path(mock_post),
        params: mock_post.as_json(only: [:title, :body, :url, :topic_id]).merge(hashtags: ['hashtag'].to_json),
        headers: auth_headers_for(user)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(mock_post)
    end

    it 'updates the image' do
      image = fixture_file_upload('logo.png', 'image/png')
      user = create(:user)
      mock_post = create(:post, author: user)

      patch post_path(mock_post),
        params: { image_file: image },
        headers: auth_headers_for(user)

      expect(mock_post.reload.image.present?).to eq true
    end

    it 'responds with errors' do
      user = create(:user)
      mock_post = create(:post, author: user)

      patch post_path(mock_post), params: { title: nil }, headers: auth_headers_for(user)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:title)
    end
  end
end
