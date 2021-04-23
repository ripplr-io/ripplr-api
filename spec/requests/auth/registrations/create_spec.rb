require 'rails_helper'

RSpec.describe :auth_registrations_create, type: :request do
  it_behaves_like :unprocessable_request, [:email, :password, 'profile.name'] do
    let(:subject) { post auth_register_path }
  end

  context 'without extra params' do
    it 'responds with the resource' do
      create(:level)
      attributes = attributes_for(:user).slice(:email, :password).merge(name: 'Name')

      post auth_register_path, params: attributes, as: :json

      expect(response).to have_http_status(:created)
      expect(response_body[:access_token]).not_to be nil
      expect(response_body[:refresh_token]).not_to be nil
      expect(User.last.referral).to eq(nil)
    end
  end

  context 'with a referral' do
    it 'responds with the resource' do
      create(:level)
      referral = create(:referral)

      attributes = attributes_for(:user)
        .slice(:email, :password)
        .merge(name: 'Name')
        .merge(referral_id: referral.id)

      post auth_register_path, params: attributes, as: :json

      expect(response).to have_http_status(:created)
      expect(User.last.referral).to eq(referral)
    end
  end
end
