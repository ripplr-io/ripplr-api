require 'rails_helper'

RSpec.describe Analytics, type: :wrapper do
  context '.client' do
    it 'uses Segment Analytics' do
      expect(described_class.send(:client).class).to eq(Segment::Analytics)
    end
  end

  context '.identify' do
    let(:client) { Segment::Analytics.new(write_key: '', stub: true) }
    before { allow(described_class).to receive(:client).and_return(client) }

    it 'passes the user id to the client' do
      user = create(:user)

      expect(client).to receive(:identify).with(hash_including(user_id: user.id))

      described_class.identify(user)
    end

    it 'passes the user traits to the client' do
      user = create(:user)

      expect(client).to receive(:identify).with(hash_including(traits: {
        email: user.email,
        name: user.name,
        createdAt: user.created_at
      }))

      described_class.identify(user)
    end
  end

  context '.track' do
    let(:client) { Segment::Analytics.new(write_key: '', stub: true) }
    before { allow(described_class).to receive(:client).and_return(client) }

    it 'passes the user id to the client' do
      user = create(:user)

      expect(client).to receive(:track).with(hash_including(user_id: user.id))

      described_class.track(user, 'Event')
    end

    it 'passes the event name to the client' do
      expect(client).to receive(:track).with(hash_including(event: 'Event'))

      described_class.track(create(:user), 'Event')
    end

    it 'passes additional properties to the client' do
      expect(client).to receive(:track).with(hash_including(properties: {
        value1: 1,
        value2: '2'
      }))

      described_class.track(create(:user), 'Event', { value1: 1, value2: '2' })
    end
  end
end
