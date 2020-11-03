require 'rails_helper'

RSpec.describe Authentication::JwtDecodeService, type: :service do
  include ActiveSupport::Testing::TimeHelpers

  it 'returns a user from a valid token' do
    user = create(:user)
    token = Warden::JWTAuth::UserEncoder.new.call(user, :users, Rails.application.credentials.secret_key_base)[0]

    service = described_class.new(token)

    expect(service.user).to eq(user)
  end

  it 'returns a user from a valid but expired token' do
    user = create(:user)
    token = Warden::JWTAuth::UserEncoder.new.call(user, :users, Rails.application.credentials.secret_key_base)[0]

    travel 1.year do
      service = described_class.new(token, validate_expiration: false)
      expect(service.user).to eq(user)
    end
  end

  it 'returns nil for an invalid token' do
    token = 'fake_token'

    service = described_class.new(token)
    expect(service.user).to be nil
  end

  it 'return nil for a manually expired token' do
    user = create(:user)
    token = Warden::JWTAuth::UserEncoder.new.call(user, :users, Rails.application.credentials.secret_key_base)[0]
    user.update(jti: SecureRandom.uuid)

    service = described_class.new(token)
    expect(service.user).to be nil
  end
end
