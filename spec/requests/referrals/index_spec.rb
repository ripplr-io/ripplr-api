require 'rails_helper'

RSpec.describe :referrals_index, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      get referrals_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the user resources' do
      user = create(:user)
      sign_in user
      user_referral = create(:referral, inviter: user)
      other_referral = create(:referral)

      get referrals_path

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(user_referral)
      expect(response_data).not_to have_resource(other_referral)
    end
  end
end
