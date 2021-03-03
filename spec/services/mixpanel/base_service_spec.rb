require 'rails_helper'

RSpec.describe Mixpanel::BaseService, type: :service do
  context '#track' do
    it 'makes the request' do
      user = create(:user)

      stub_request(:post, /mixpanel.com/).to_return(status: 200, body: { status: 1 }.to_json)

      described_class.new(user).track('Test Event')
    end

    context 'the user is a bot' do
      it 'skips the request' do
        user = create(:user)
        create(:content_source, user: user)

        described_class.new(user).track('Test Event')
      end
    end
  end

  context '#sync_user' do
    it 'makes the request' do
      user = create(:user)

      stub_request(:post, /mixpanel.com/).to_return(status: 200, body: { status: 1 }.to_json)

      described_class.new(user).sync_user
    end

    context 'the user is a bot' do
      it 'skips the request' do
        user = create(:user)
        create(:content_source, user: user)

        described_class.new(user).sync_user
      end
    end
  end
end
