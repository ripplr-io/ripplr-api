require 'rails_helper'

RSpec.describe :posts_proxies_show, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { get post_proxy_path(0) }
  end

  it 'responds with not found' do
    post = create(:post)

    get post_proxy_path(post), headers: auth_headers_for_new_user

    expect(response).to redirect_to(post.url)
    expect(Mixpanel::TrackPostViewWorker.jobs.size).to eq 1
  end
end
