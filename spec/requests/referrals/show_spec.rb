require 'rails_helper'

RSpec.describe :referrals_show, type: :request do
  it 'responds with the resource' do
    referral = create(:referral)

    get referral_path(referral)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(referral)
  end

  it 'responds with not found' do
    get referral_path(0)

    expect(response).to have_http_status(:not_found)
  end
end
