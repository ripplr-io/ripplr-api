require 'rails_helper'

RSpec.describe :account_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch account_path }
  end

  it_behaves_like :unprocessable_request, [:timezone, :email] do
    let(:subject) do
      patch account_path,
        params: { timezone: nil, email: nil },
        headers: auth_headers_for_new_user
    end
  end

  it 'responds with the resource' do
    user = create(:user)

    patch account_path,
      params: user.as_json(only: [:country, :email, :timezone]),
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(user)
  end
end
