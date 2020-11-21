class BookmarksController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!
  before_action :find_bookmark, only: [:update, :destroy]

  def create
    @bookmark = current_user.bookmarks.new(bookmark_params)
    create_resource(@bookmark)
  end

  def update
    @bookmark.assign_attributes(bookmark_params)
    update_resource(@bookmark)
  end

  def destroy
    destroy_resource(@bookmark)
  end

  private

  def find_bookmark
    @bookmark = current_user.bookmarks.find(params[:id])
  end

  def bookmark_params
    params.permit(:post_id, :bookmark_folder_id)
  end
end
