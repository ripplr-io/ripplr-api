require 'rails_helper'

RSpec.describe :subscriptions_create, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      post referrals_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
      user = create(:user)
      sign_in user
      mock_referral_a = build(:referral, inviter: user)
      mock_referral_b = build(:referral, inviter: user)

      post referrals_path, as: :json, params: {
        referrals: [
          mock_referral_a.as_json(only: [:name, :email]),
          mock_referral_b.as_json(only: [:name, :email])
        ]
      }

      new_referrals = Referral.last(2)
      expect(new_referrals.size).to eq(2)
      expect(new_referrals - user.reload.referrals).to be_empty
    end
  end
end
