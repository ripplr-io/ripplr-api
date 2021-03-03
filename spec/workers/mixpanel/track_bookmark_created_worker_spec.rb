require 'rails_helper'

RSpec.describe Mixpanel::TrackBookmarkCreatedWorker, type: :worker do
  it 'calls the mixpanel service' do
    bookmark = create(:bookmark)

    expect(Mixpanel::BaseService).to receive(:new).with(bookmark.user).and_call_original
    expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with('Bookmark Created')

    described_class.new.perform(bookmark.id)
  end
end
