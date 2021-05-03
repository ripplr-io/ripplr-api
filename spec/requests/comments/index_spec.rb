require 'rails_helper'

RSpec.describe :comments_index, type: :request do
  it 'responds with the post resources' do
    mock_post = create(:post)
    post_comment = create(:comment, post: mock_post)
    other_comment = create(:comment)

    get post_comments_path(mock_post)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(post_comment)
    expect(response_data).not_to have_resource(other_comment)
    expect(response_included).to have_resource(post_comment.author)
  end
end
