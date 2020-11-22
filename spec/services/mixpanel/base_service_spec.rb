require 'rails_helper'

RSpec.describe Mixpanel::BaseService, type: :service do
  context '#track' do
    it 'returns true on success' do
      user = create(:user)

      stub_request(:post, /mixpanel.com/).to_return(status: 200, body: { status: 1 }.to_json)

      instance = described_class.new(user.id)
      expect(instance.track('Test Event')).to eq true
    end
  end

  context '#sync_user' do
    it 'returns true on success' do
      user = create(:user)

      stub_request(:post, /mixpanel.com/).to_return(status: 200, body: { status: 1 }.to_json)

      instance = described_class.new(user.id)
      expect(instance.sync_user).to eq true
    end

    it 'returns nil if the user does not exist' do
      instance = described_class.new(nil)
      expect(instance.sync_user).to eq nil
    end
  end
end
