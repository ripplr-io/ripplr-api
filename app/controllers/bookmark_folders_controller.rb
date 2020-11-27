class BookmarkFoldersController < ApplicationController
  include Crudable

  load_and_authorize_resource

  # TODO: Use cancancan
  def index
    read_resource(current_user.root_bookmark_folder, included_associations: [
      :folders,
      :bookmarks,
      'bookmarks.post',
      'bookmarks.post.author',
      'bookmarks.post.topic',
      'bookmarks.post.hashtags'
    ])
  end

  def show
    read_resource(@bookmark_folder, included_associations: [
      :folders,
      :bookmarks,
      'bookmarks.post',
      'bookmarks.post.author',
      'bookmarks.post.topic',
      'bookmarks.post.hashtags'
    ])
  end

  def create
    create_resource(@bookmark_folder)
  end

  def update
    @bookmark_folder.assign_attributes(bookmark_folder_params)
    update_resource(@bookmark_folder)
  end

  def destroy
    destroy_resource(@bookmark_folder)
  end

  private

  def bookmark_folder_params
    params.permit(:name, :bookmark_folder_id)
  end
end
