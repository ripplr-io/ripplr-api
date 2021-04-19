require 'rails_helper'

RSpec.describe :comments_destroy, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { delete comment_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      comment = create(:comment)
      delete comment_path(comment), headers: auth_headers_for_new_user
    end
  end

  it 'responds with the resource' do
    comment = create(:comment)

    delete comment_path(comment), headers: auth_headers_for(comment.author)

    expect(response).to have_http_status(:no_content)
  end
end
