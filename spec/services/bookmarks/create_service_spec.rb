require 'rails_helper'

RSpec.describe Bookmarks::CreateService, type: :service do
  it 'creates the bookmark' do
    bookmark = build(:bookmark)

    expect { described_class.new(bookmark).save }
      .to change { Bookmark.count }.by(1)

    expect(Mixpanel::TrackBookmarkCreatedWorker.jobs.size).to eq 1
  end
end
