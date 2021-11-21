require 'rails_helper'

RSpec.describe Sendgrid::ContactService, type: :service do
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

      instance.sync_user(create(:user))
    end

    context 'user is bot' do
      it 'returns early' do
        instance = described_class.new
        expect(instance).not_to receive(:upsert_contacts)

        user = create(:content_source).user
        user.profile.update(bot: true)

        instance.sync_user(user)
      end
    end
  end

  context '#upsert_contacts' do
    it 'does not raise an error' do
      stub_request(:put, /api.sendgrid.com/).to_return(status: 202)
      described_class.new.send(:upsert_contacts, ['email@example.com'])

      stub_request(:put, /api.sendgrid.com/).to_return(status: 400)
      described_class.new.send(:upsert_contacts, nil)
    end
  end
end
