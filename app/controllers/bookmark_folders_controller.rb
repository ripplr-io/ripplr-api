class BookmarkFoldersController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource
  skip_load_resource only: :index

  serializer include: [
    :folders,
    :bookmarks,
    'bookmarks.post',
    'bookmarks.post.author',
    'bookmarks.post.topic',
    'bookmarks.post.hashtags'
  ]

  def index
    read_resource(current_user.root_bookmark_folder)
  end

  def show
    read_resource(@bookmark_folder)
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
