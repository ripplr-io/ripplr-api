require 'rails_helper'

RSpec.describe PushNotifications::SettingsService, type: :service do
  context '#topic_subscribed?' do
    context 'the topic is included in the subscription settings' do
      it 'returns true' do
        post = create(:post)
        subscription = create(:subscription, settings: {
          topics: {
            value: 'all'
          }
        }.as_json)
        device = create(:device)

        service = described_class.new(post, subscription, device)
        expect(service.topic_subscribed?).to be true
      end
    end

    context 'the topic is included in the device settings' do
      it 'returns true' do
        post = create(:post)
        subscription = create(:subscription, settings: {
          topics: {
            value: 'devices'
          }
        }.as_json)
        device = create(:device, settings: {
          topics: {
            value: 'all'
          }
        }.as_json)

        service = described_class.new(post, subscription, device)
        expect(service.topic_subscribed?).to be true
      end
    end

    context 'the topic is not included in the settings' do
      it 'returns false' do
        post = create(:post)
        subscription = create(:subscription, settings: {
          topics: {
            value: 'only',
            only: []
          }
        }.as_json)
        device = create(:device)

        service = described_class.new(post, subscription, device)
        expect(service.topic_subscribed?).to be false
      end
    end
  end

  context '#next_available_slot' do
    it 'returns the next slot in the subscription settings' do
      bod = Time.current.beginning_of_day
      allow(Time).to receive(:current).and_return(bod)

      post = create(:post)
      subscription = create(:subscription, settings: {
        availability: {
          value: 'only',
          only: ['12:00']
        }
      }.as_json)
      device = create(:device)

      service = described_class.new(post, subscription, device)
      expect(service.next_available_slot).to eq bod + 12.hours
    end

    it 'returns the next slot in the device settings' do
      bod = Time.current.beginning_of_day
      allow(Time).to receive(:current).and_return(bod)

      post = create(:post)
      subscription = create(:subscription, settings: {
        availability: {
          value: 'devices'
        }
      }.as_json)
      device = create(:device, settings: {
        availability: {
          value: 'only',
          only: ['12:00']
        }
      }.as_json)

      service = described_class.new(post, subscription, device)
      expect(service.next_available_slot).to eq bod + 12.hours
    end
  end

  context '#topics_from_settings' do
    context 'all' do
      it 'returns all existing topics' do
        create_list(:topic, 2)
        subscription = create(:subscription)
        settings = {
          value: 'all'
        }.as_json

        service = described_class.new(nil, subscription, nil)
        topics = service.send(:topics_from_settings, settings)

        expect(topics.pluck(:id)).to eq Topic.all.pluck(:id)
      end
    end

    context 'only' do
      it 'returns only topics from the list' do
        create_list(:topic, 2)
        subscription = create(:subscription)
        settings = {
          value: 'only',
          only: [Topic.first.id]
        }.as_json

        service = described_class.new(nil, subscription, nil)
        topics = service.send(:topics_from_settings, settings)

        expect(topics.pluck(:id)).to eq [Topic.first.id]
      end
    end

    context 'except' do
      it 'returns existing topics except list' do
        create_list(:topic, 2)
        subscription = create(:subscription)
        settings = {
          value: 'except',
          except: [Topic.first.id]
        }.as_json

        service = described_class.new(nil, subscription, nil)
        topics = service.send(:topics_from_settings, settings)

        expect(topics.pluck(:id)).to eq [Topic.second.id]
      end
    end

    context 'followed' do
      it 'returns topics that the user follows' do
        create_list(:topic, 2)
        subscription = create(:subscription)
        create(:follow, user: subscription.user, followable: Topic.first)
        settings = {
          value: 'followed'
        }.as_json

        service = described_class.new(nil, subscription, nil)
        topics = service.send(:topics_from_settings, settings)

        expect(topics.pluck(:id)).to eq [Topic.first.id]
      end
    end

    context 'invalid' do
      it 'returns all existing topics' do
        create_list(:topic, 2)
        subscription = create(:subscription)
        settings = {}.as_json

        service = described_class.new(nil, subscription, nil)
        topics = service.send(:topics_from_settings, settings)

        expect(topics.pluck(:id)).to eq Topic.all.pluck(:id)
      end
    end
  end

  context '#slots_from_settings' do
    context 'all' do
      it 'returns all slots' do
        settings = {
          value: 'all'
        }.as_json

        service = described_class.new(nil, nil, nil)
        slots = service.send(:slots_from_settings, settings)

        expect(slots.size).to eq 24
      end
    end

    context 'only' do
      it 'returns only slots from the list' do
        settings = {
          value: 'only',
          only: ['10:00', '20:00']
        }.as_json

        service = described_class.new(nil, nil, nil)
        slots = service.send(:slots_from_settings, settings)

        expect(slots.size).to eq 2
      end
    end

    context 'except' do
      it 'returns all slots except from the list' do
        settings = {
          value: 'except',
          except: ['10:00', '20:00']
        }.as_json

        service = described_class.new(nil, nil, nil)
        slots = service.send(:slots_from_settings, settings)

        expect(slots.size).to eq 22
      end
    end

    context 'invalid' do
      it 'returns all slots' do
        settings = {}.as_json

        service = described_class.new(nil, nil, nil)
        slots = service.send(:slots_from_settings, settings)

        expect(slots.size).to eq 24
      end
    end
  end
end
