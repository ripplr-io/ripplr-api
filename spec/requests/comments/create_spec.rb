require 'rails_helper'

RSpec.describe :comments_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) do
      mock_post = create(:post)
      post post_comments_path(mock_post)
    end
  end

  it_behaves_like :unprocessable_request, [:body] do
    let(:subject) do
      mock_post = create(:post)
      post post_comments_path(mock_post), headers: auth_headers_for_new_user
    end
  end

  it 'responds with the comment' do
    user = create(:user)
    mock_post = create(:post)

    post post_comments_path(mock_post),
      params: { body: 'Body' },
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(Comment.last)
    expect(response_included).to have_resource(Comment.last.author)
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
    expect(response_included).to have_resource(Comment.last.author)
  end
end
