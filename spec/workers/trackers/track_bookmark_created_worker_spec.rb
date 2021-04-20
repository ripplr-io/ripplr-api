require 'rails_helper'

RSpec.describe Trackers::TrackBookmarkCreatedWorker, type: :worker do
  it 'calls the service' do
    bookmark = create(:bookmark)

    expect(Analytics).to receive(:track).with(bookmark.user, 'Bookmark Created')

    described_class.new.perform(bookmark.id)
  end
end
