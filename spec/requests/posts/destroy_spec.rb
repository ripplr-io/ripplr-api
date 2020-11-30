require 'rails_helper'

RSpec.describe :posts_destroy, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { delete post_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      mock_post = create(:post)
      delete post_path(mock_post), headers: auth_headers_for_new_user
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    mock_post = create(:post, author: user)

    delete post_path(mock_post), headers: auth_headers_for(user)

    expect(response).to have_http_status(:no_content)
  end
end
