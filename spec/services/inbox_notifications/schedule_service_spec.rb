require 'rails_helper'

RSpec.describe InboxNotifications::ScheduleService, type: :service do
  context '#next_available_slot' do
    it 'returns the next slot in the inbox_channel settings' do
      bod = Time.current.beginning_of_day
      allow(Time).to receive(:current).and_return(bod)

      inbox_channel = create(:inbox_channel, settings: {
        availability: {
          value: 'only',
          only: ['12:00']
        }
      }.as_json)

      inbox_notification = create(:inbox_notification, inbox_channel: inbox_channel)

      service = described_class.new(inbox_notification)
      expect(service.next_available_slot).to eq bod + 12.hours
    end

    it 'returns the next slot in the channel settings' do
      bod = Time.current.beginning_of_day
      allow(Time).to receive(:current).and_return(bod)

      channel = create(:channel, settings: {
        availability: {
          value: 'only',
          only: ['12:00']
        }
      }.as_json)

      inbox_channel = create(:inbox_channel, channel: channel, user: channel.user, settings: nil)
      inbox_notification = create(:inbox_notification, inbox_channel: inbox_channel)

      service = described_class.new(inbox_notification)
      expect(service.next_available_slot).to eq bod + 12.hours
    end
  end

  context '#slots_from_settings' do
    context 'all' do
      it 'returns all slots' do
        settings = {
          value: 'all'
        }.as_json

        service = described_class.new(create(:inbox_notification))
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

        service = described_class.new(create(:inbox_notification))
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

        service = described_class.new(create(:inbox_notification))
        slots = service.send(:slots_from_settings, settings)

        expect(slots.size).to eq 22
      end
    end

    context 'invalid' do
      it 'returns all slots' do
        settings = {}.as_json

        service = described_class.new(create(:inbox_notification))
        slots = service.send(:slots_from_settings, settings)

        expect(slots.size).to eq 24
      end
    end
  end
end
