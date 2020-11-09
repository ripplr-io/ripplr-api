class BookmarksController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!

  def index
    read_resource(current_user.root_bookmark_folder, included_associations: [
      :bookmarks,
      :folders,
      'folders.folders',
      'bookmarks.post',
      'bookmarks.post.author',
      'bookmarks.post.topic',
      'bookmarks.post.hashtags'
    ])
  end

  def create
    @bookmark = current_user.bookmarks.new(bookmark_params)
    create_resource(@bookmark, included_associations: [:post])
  end

  private

  def bookmark_params
    params.permit(:post_id, :bookmark_folder_id)
  end
end
