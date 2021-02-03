require 'rails_helper'

RSpec.describe Sendgrid::SubscriptionService, type: :service do
  context '#create_lead' do
    it 'upserts 1 contact with the email' do
      instance = described_class.new
      expect(instance).to receive(:upsert_contacts)

      instance.create_lead('email@example.com')
    end
  end

  context '#sync_user' do
    it 'upserts a user and updates its subscription status' do
      instance = described_class.new
      expect(instance).to receive(:upsert_contacts)
      expect(instance).to receive(:update_subscription)

      instance.sync_user(create(:user))
    end
  end

  context '#update_subscription' do
    it 'calls the correct endpoint' do
      instance = described_class.new

      expect(instance).to receive(:subscribe)
      instance.send(:update_subscription, 'email@example.com', true)

      expect(instance).to receive(:unsubscribe)
      instance.send(:update_subscription, 'email@example.com', false)
    end
  end

  context '#upsert_contacts' do
    it 'does not raise an error' do
      stub_request(:put, /api.sendgrid.com/).to_return(status: 202)
      described_class.new.send(:upsert_contacts, ['email@example.com'], ['list_id'])

      stub_request(:put, /api.sendgrid.com/).to_return(status: 400)
      described_class.new.send(:upsert_contacts, nil, nil)
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
