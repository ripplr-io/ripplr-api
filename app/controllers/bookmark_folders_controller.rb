class BookmarkFoldersController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!
  before_action :find_bookmark_folder, only: [:show, :update, :destroy]

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
    bookmark_folder = current_user.bookmark_folders.new(folder_params)
    create_resource(bookmark_folder)
  end

  def update
    @bookmark_folder.assign_attributes(folder_params)
    update_resource(@bookmark_folder)
  end

  def destroy
    destroy_resource(@bookmark_folder)
  end

  private

  def find_bookmark_folder
    @bookmark_folder = current_user.bookmark_folders.find(params[:id])
  end

  def folder_params
    params.permit(:name, :bookmark_folder_id)
  end
end
