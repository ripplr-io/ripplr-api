require 'rails_helper'

RSpec.describe InboxItems::UpdateArchive, type: :interactor do
  it 'updates the inbox_item' do
    inbox_item = create(:inbox_item, archived_at: nil)
    inbox_item.archived_at = Time.current

    described_class.call(resource: inbox_item)

    expect(inbox_item.reload.archived_at).not_to eq(nil)
    expect(Mixpanel::TrackInboxItemArchiveWorker.jobs.size).to eq(1)
  end
end
