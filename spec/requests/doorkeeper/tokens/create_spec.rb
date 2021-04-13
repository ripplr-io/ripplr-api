require 'rails_helper'

RSpec.describe :doorkeeper_tokens_create, type: :request do
  context 'with email and password' do
    it 'logs in the user' do
      user = create(:user, password: '123456')

      post oauth_token_path, params: {
        grant_type: 'password',
        email: user.email,
        password: '123456'
      }

      expect(Segment::TrackLoginWorker.jobs.size).to eq(1)
    end
  end

  context 'with a refresh token' do
    it 'logs in the user' do
      user = create(:user)
      user.access_tokens.create!(
        use_refresh_token: true,
        expires_in: Doorkeeper.configuration.access_token_expires_in
      )

      post oauth_token_path, params: {
        grant_type: 'refresh_token',
        refresh_token: user.access_tokens.last.refresh_token
      }

      expect(Segment::TrackLoginWorker.jobs.size).to eq(1)
    end
  end

  context 'with invalid authentication' do
    it 'does not log in the user' do
      post oauth_token_path, params: { grant_type: 'password' }
      expect(Segment::TrackLoginWorker.jobs.size).to eq(0)

      post oauth_token_path, params: { grant_type: 'refresh_token' }
      expect(Segment::TrackLoginWorker.jobs.size).to eq(0)
    end
  end
end
