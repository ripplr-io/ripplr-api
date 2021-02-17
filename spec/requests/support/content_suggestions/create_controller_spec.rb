require 'rails_helper'

RSpec.describe :support_content_suggestions_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post support_content_suggestions_path }
  end

  it_behaves_like :unprocessable_request, [:topic, :name, :url] do
    let(:subject) do
      post support_content_suggestions_path, headers: auth_headers_for_new_user
    end
  end

  it 'responds with no content' do
    expect(Slack::NotifyService).to receive(:new).and_call_original

    post support_content_suggestions_path,
      params: { topic_id: create(:topic).id, name: 'Name', url: 'url.com' },
      headers: auth_headers_for_new_user

    expect(response).to have_http_status(:no_content)
  end
end
