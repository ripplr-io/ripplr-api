require 'rails_helper'

RSpec.describe :follows_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post follows_path }
  end

  it_behaves_like :unprocessable_request, [:followable] do
    let(:subject) { post follows_path, headers: auth_headers_for_new_user }
  end

  it 'responds with the resource' do
    user = create(:user)
    followable = create(:profile)
    mock_follow = build(:follow, followable: followable)

    post follows_path,
      params: mock_follow.as_json(only: [:followable_id, :followable_type]),
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(Follow.last)
    expect(response_included).to have_resource(Follow.last.followable)
  end
end
