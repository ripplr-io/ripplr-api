require 'rails_helper'

RSpec.describe Sendgrid::SubscriptionService, type: :service do
  context '#sync_user' do
    it 'calls the correct endpoint' do
      instance = described_class.new

      expect(instance).to receive(:subscribe)
      instance.sync_user(create(:user, subscribed_to_marketing: true))

      expect(instance).to receive(:unsubscribe)
      instance.sync_user(create(:user, subscribed_to_marketing: false))
    end
  end

  context '#unsubscribe' do
    it 'does not raise an error' do
      stub_request(:post, /api.sendgrid.com/).to_return(status: 201)
      described_class.new.send(:unsubscribe, 'email@example.com')

      stub_request(:post, /api.sendgrid.com/).to_return(status: 400)
      described_class.new.send(:unsubscribe, nil)
    end
  end

  context '#subscribe' do
    it 'does not raise an error' do
      stub_request(:delete, /api.sendgrid.com/).to_return(status: 204)
      described_class.new.send(:subscribe, 'email@example.com')

      stub_request(:delete, /api.sendgrid.com/).to_return(status: 404)
      described_class.new.send(:subscribe, nil)
    end
  end
end
