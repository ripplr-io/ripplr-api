require 'rails_helper'

RSpec.describe :posts_show, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { get post_path(0) }
  end

  it 'responds with the resource' do
    user = create(:user)
    post = create(:post)
    create(:rating, ratable: post, user: user)

    get post_path(post), headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(post)
  end

  it 'responds with not found' do
    user = create(:user)

    get post_path(0), headers: auth_headers_for(user)

    expect(response).to have_http_status(:not_found)
  end

  it 'reponds with included associations' do
    user = create(:user)
    post_hashtag = create(:post_hashtag)
    post = post_hashtag.post
    bookmark = create(:bookmark, post: post, user: user)

    get post_path(post), headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_included).to have_resource(post.author)
    expect(response_included).to have_resource(post.topic)
    expect(response_included).to have_resource(post.hashtags.first)
    expect(response_included).to have_resource(bookmark)
  end
end
