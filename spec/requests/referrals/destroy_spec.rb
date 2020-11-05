require 'rails_helper'

RSpec.describe :referrals_destroy, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      delete referral_path(0)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user does not own the resource' do
    it 'responds with not found' do
      user = create(:user)
      referral = create(:referral)

      delete referral_path(referral), headers: auth_headers_for(user)

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user owns the resource' do
    it 'responds with the resource' do
      user = create(:user)
      referral = create(:referral, inviter: user)

      delete referral_path(referral), headers: auth_headers_for(user)

      expect(response).to have_http_status(:no_content)
    end
  end
end
