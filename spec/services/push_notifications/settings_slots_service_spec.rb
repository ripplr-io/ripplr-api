require 'rails_helper'

RSpec.describe PushNotifications::SettingsSlotsService, type: :service do
  context '#next_available_slot' do
    context 'without slots' do
      it 'returns nil' do
        next_slot = described_class.new([]).next_available_slot
        expect(next_slot).to be nil
      end
    end

    context 'without invalid slots' do
      it 'returns nil' do
        next_slot = described_class.new([Time.current, '5', 5, '25:00']).next_available_slot
        expect(next_slot).to be nil
      end
    end

    context 'at the beggining of the day' do
      it 'returns a slot in the same day' do
        bod = Time.current.beginning_of_day
        allow(Time).to receive(:current).and_return(bod)

        next_slot = described_class.new(['00:00', '10:00', '20:00']).next_available_slot
        expect(next_slot).to eq bod

        next_slot = described_class.new(['10:00', '20:00']).next_available_slot
        expect(next_slot).to eq bod + 10.hours

        next_slot = described_class.new(['20:00']).next_available_slot
        expect(next_slot).to eq bod + 20.hours
      end
    end

    context 'at the end of the day' do
      it 'returns slots in the same day or the next day' do
        bod = Time.current.beginning_of_day
        allow(Time).to receive(:current).and_return(bod + 18.hours)

        next_slot = described_class.new(['00:00', '10:00', '20:00']).next_available_slot
        expect(next_slot).to eq bod + 20.hours

        next_slot = described_class.new(['00:00', '10:00']).next_available_slot
        expect(next_slot).to eq bod + 1.day

        next_slot = described_class.new(['10:00']).next_available_slot
        expect(next_slot).to eq bod + 1.day + 10.hours
      end
    end
  end
end
