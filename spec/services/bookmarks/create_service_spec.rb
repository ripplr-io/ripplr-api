require 'rails_helper'

RSpec.describe Bookmarks::CreateService, type: :service do
  it 'creates the bookmark' do
    user = create(:user)
    bookmark_params = {
      post: create(:post),
      user: user,
      bookmark_folder: user.root_bookmark_folder
    }

    expect { described_class.new(bookmark_params).save }
      .to change { Bookmark.count }.by(1)

    expect(Mixpanel::TrackBookmarkCreatedWorker.jobs.size).to eq 1
  end
end
