require 'rails_helper'

RSpec.describe Segment::TrackBookmarkCreatedWorker, type: :worker do
  it 'calls the service' do
    bookmark = create(:bookmark)

    expect_any_instance_of(Segment::TrackService).to receive(:call).with(bookmark.user, 'Bookmark Created')

    described_class.new.perform(bookmark.id)
  end
end
