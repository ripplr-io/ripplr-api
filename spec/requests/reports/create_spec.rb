require 'rails_helper'

RSpec.describe :reports_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post post_reports_path(0) }
  end

  it_behaves_like :unprocessable_request, [:reason, :body] do
    let(:subject) do
      mock_post = create(:post)
      post post_reports_path(mock_post), headers: auth_headers_for_new_user
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    mock_post = create(:post)

    post post_reports_path(mock_post), params: { reason: 'reason', body: 'body' }, headers: auth_headers_for(user)

    expect(response).to have_http_status(:no_content)
    expect(Support::NewReportMailer.jobs.size).to eq(1)
  end
end
