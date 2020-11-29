require 'rails_helper'

RSpec.describe :comments_create, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with not_found' do
      mock_post = create(:post)
      post post_comments_path(mock_post)
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the comment' do
      user = create(:user)
      mock_post = create(:post)

      post post_comments_path(mock_post),
        params: { body: 'Body' },
        headers: auth_headers_for(user)

      expect(response).to have_http_status(:created)
      expect(response_data).to have_resource(Comment.last)
    end

    it 'responds with the reply' do
      user = create(:user)
      mock_post = create(:post)
      other_comment = create(:comment, post: mock_post)

      post post_comments_path(mock_post),
        params: { body: 'Body', comment_id: other_comment.id },
        headers: auth_headers_for(user)

      expect(response).to have_http_status(:created)
      expect(response_data).to have_resource(Comment.last)
    end

    it 'responds with errors' do
      user = create(:user)
      mock_post = create(:post)

      post post_comments_path(mock_post), headers: auth_headers_for(user)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:body)
    end
  end
end
