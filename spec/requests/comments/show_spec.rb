require 'rails_helper'

RSpec.describe :comments_show, type: :request do
  it 'responds with the comment resources' do
    mock_comment = create(:comment)
    comment_reply = create(:reply, comment: mock_comment)
    other_reply = create(:reply)

    get post_comment_path(mock_comment.post, mock_comment)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(comment_reply)
    expect(response_data).not_to have_resource(other_reply)
  end

  it 'responds with not found' do
    mock_post = create(:post)
    get post_comment_path(mock_post, 0)
    expect(response).to have_http_status(:not_found)
  end
end
