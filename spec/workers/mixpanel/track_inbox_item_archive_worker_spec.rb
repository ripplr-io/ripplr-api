require 'rails_helper'

RSpec.describe Mixpanel::TrackInboxItemArchiveWorker, type: :worker do
  context 'item was archived' do
    it 'calls the mixpanel service' do
      inbox_item = create(:inbox_item, archived_at: nil)

      expect(Mixpanel::BaseService).to receive(:new).with(inbox_item.inbox.user).and_call_original
      expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with('InboxItem Unarchived')

      described_class.new.perform(inbox_item.id)
    end
  end

  context 'item was archived' do
    it 'calls the mixpanel service' do
      inbox_item = create(:inbox_item, archived_at: Time.current)

      expect(Mixpanel::BaseService).to receive(:new).with(inbox_item.inbox.user).and_call_original
      expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with('InboxItem Archived')

      described_class.new.perform(inbox_item.id)
    end
  end
end
