class BookmarksController < ApplicationController
  include Crudable

  load_and_authorize_resource

  def create
    # TODO: Use cancancan
    @bookmark = Bookmarks::CreateService.new(bookmark_params.merge(user: current_user))
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

  def bookmark_params
    params.permit(:post_id, :bookmark_folder_id)
  end
end
