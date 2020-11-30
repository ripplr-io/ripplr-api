require 'rails_helper'

RSpec.describe :referrals_index, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { get referrals_path }
  end

  it 'responds with the user resources' do
    user = create(:user)
    user_referral = create(:referral, inviter: user)
    other_referral = create(:referral)

    get referrals_path, headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(user_referral)
    expect(response_data).not_to have_resource(other_referral)
  end
end
