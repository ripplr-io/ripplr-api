require 'rails_helper'

RSpec.describe :posts_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch comment_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      comment = create(:post)
      patch comment_path(comment), headers: auth_headers_for_new_user
    end
  end

  it_behaves_like :unprocessable_request, [:body] do
    let(:subject) do
      comment = create(:comment)

      patch comment_path(comment),
        params: { body: nil },
        headers: auth_headers_for(comment.author)
    end
  end

  it 'responds with the resource' do
    comment = create(:comment)

    patch comment_path(comment),
      params: attributes_for(:post).slice(:body),
      headers: auth_headers_for(comment.author)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(comment)
  end
end
