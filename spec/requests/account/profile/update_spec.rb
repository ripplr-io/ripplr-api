require 'rails_helper'

RSpec.describe :account_profile_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch account_profile_path }
  end

  it_behaves_like :unprocessable_request, [:name] do
    let(:subject) do
      patch account_profile_path,
        params: { name: nil },
        headers: auth_headers_for_new_user
    end
  end

  it 'responds with the resource' do
    user = create(:user)

    patch account_profile_path,
      params: user.as_json(only: [:name, :slug, :bio]),
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(user)
  end

  it 'updates the avatar' do
    avatar = fixture_file_upload('logo.png', 'image/png')
    user = create(:user)

    patch account_profile_path,
      params: { avatar_file: avatar },
      headers: auth_headers_for(user)

    expect(user.reload.avatar.present?).to eq true
  end
end
