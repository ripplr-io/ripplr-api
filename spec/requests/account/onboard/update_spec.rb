require 'rails_helper'

RSpec.describe :account_onboard_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch account_onboard_path }
  end

  it 'responds with the resource' do
    user = create(:user)

    put account_onboard_path, headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(user)
  end
end
