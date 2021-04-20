require 'rails_helper'

RSpec.describe Bookmarks::Create, type: :interactor do
  it 'creates the bookmark' do
    bookmark = build(:bookmark)

    expect { described_class.call(resource: bookmark) }
      .to change { Bookmark.count }.by(1)

    expect(Trackers::TrackBookmarkCreatedWorker.jobs.size).to eq 1
  end
end
