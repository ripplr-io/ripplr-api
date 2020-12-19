class BookmarksController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource

  def create
    create_resource(@bookmark, interactor: Bookmarks::Create)
  end

  def update
    @bookmark.assign_attributes(bookmark_params)
    update_resource(@bookmark)
  end

  def destroy
    destroy_resource(@bookmark)
  end

  private

  def bookmark_params
    params.permit(:post_id, :bookmark_folder_id)
  end
end
