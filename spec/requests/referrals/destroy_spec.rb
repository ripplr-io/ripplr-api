require 'rails_helper'

RSpec.describe :referrals_destroy, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { delete referral_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      referral = create(:referral)
      delete referral_path(referral), headers: auth_headers_for_new_user
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    referral = create(:referral, inviter: user)

    delete referral_path(referral), headers: auth_headers_for(user)

    expect(response).to have_http_status(:no_content)
  end
end
