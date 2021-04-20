require 'rails_helper'

RSpec.describe Trackers::TrackInboxItemArchiveWorker, type: :worker do
  context 'item was archived' do
    it 'calls the service' do
      inbox_item = create(:inbox_item, archived_at: nil)

      expect(Analytics).to receive(:track).with(
        inbox_item.inbox.user,
        'InboxItem Unarchived'
      )

      described_class.new.perform(inbox_item.id)
    end
  end

  context 'item was archived' do
    it 'calls the service' do
      inbox_item = create(:inbox_item, archived_at: Time.current)

      expect(Analytics).to receive(:track).with(
        inbox_item.inbox.user,
        'InboxItem Archived'
      )

      described_class.new.perform(inbox_item.id)
    end
  end
end
