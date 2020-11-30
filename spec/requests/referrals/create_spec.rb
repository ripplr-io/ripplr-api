require 'rails_helper'

RSpec.describe :subscriptions_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post referrals_path }
  end

  it 'responds with the resources' do
    user = create(:user)
    mock_referral_a = build(:referral, inviter: user)
    mock_referral_b = build(:referral, inviter: user)

    post referrals_path, params: {
      referrals: [
        mock_referral_a.as_json(only: [:name, :email]),
        mock_referral_b.as_json(only: [:name, :email])
      ]
    }, headers: auth_headers_for(user)

    new_referrals = Referral.last(2)
    expect(new_referrals.size).to eq(2)
    expect(new_referrals - user.reload.referrals).to be_empty
    expect(response_data).to have_resource(Referral.last)
  end
end
