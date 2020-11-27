require 'rails_helper'

RSpec.describe :subscriptions_create, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with not_found' do
      post referrals_path
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
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
end
