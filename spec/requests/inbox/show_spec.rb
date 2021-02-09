require 'rails_helper'

RSpec.describe :inbox_show, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { get main_inbox_path }
  end

  it 'responds with the user resources' do
    user = create(:user)
    subscription = create(:subscription, user: user)
    push_notification = create(:push_notification, subscription: subscription)
    other_push_notification = create(:push_notification)

    get main_inbox_path, headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(push_notification.post)
    expect(response_data).not_to have_resource(other_push_notification.post)
  end

  it 'reponds with included associations' do
    user = create(:user)
    post_hashtag = create(:post_hashtag)
    post = post_hashtag.post
    bookmark = create(:bookmark, post: post, user: user)
    subscription = create(:subscription, user: user)
    create(:push_notification, subscription: subscription, post: post)

    get main_inbox_path, headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_included).to have_resource(post.author)
    expect(response_included).to have_resource(post.topic)
    expect(response_included).to have_resource(post.hashtags.first)
    expect(response_included).to have_resource(bookmark)
  end
end