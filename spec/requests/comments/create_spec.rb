require 'rails_helper'

RSpec.describe :comments_create, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      mock_post = create(:post)
      post post_comments_path(mock_post)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
      user = create(:user)
      sign_in user
      mock_post = create(:post)
      mock_comment = build(:comment, post: mock_post)

      post post_comments_path(mock_post), as: :json, params: mock_comment.as_json(only: [:body, :post_id])

      expect(response).to have_http_status(:created)
      expect(response_data).to have_resource(Comment.last)
    end

    it 'responds with errors' do
      user = create(:user)
      sign_in user
      mock_post = create(:post)

      post post_comments_path(mock_post)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:body)
    end
  end
end