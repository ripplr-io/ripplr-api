require 'rails_helper'

RSpec.describe :comments_show, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { get comment_path(0) }
  end

  it 'responds with the comment resources' do
    comment = create(:comment)
    comment_reply = create(:reply, comment: comment)
    other_reply = create(:reply)

    get comment_path(comment)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(comment_reply)
    expect(response_data).not_to have_resource(other_reply)
    expect(response_included).to have_resource(comment_reply.author)
  end
end
