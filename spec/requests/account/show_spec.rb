require 'rails_helper'

RSpec.describe :account_show, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { get account_path }
  end

  it 'responds with the user resource' do
    user = create(:user)

    get account_path, headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(user)
    expect(response_included).to have_resource(user.level)
  end
end
