class BookmarksController < ApplicationController
  include Crudable

  before_action :authenticate_user!

  def index
    render json: current_user.root_bookmark_folder, include: [
      :bookmarks, 'bookmarks.post', 'bookmarks.post.author', 'bookmarks.post.topic', 'bookmarks.post.hashtags'
    ]
  end

  def create
    @bookmark = current_user.bookmark_folders.find(params[:bookmark_folder_id]).bookmarks.new(bookmark_params)
    create_resource(@bookmark)
  end

  private

  def bookmark_params
    params.permit(:post_id, :bookmark_folder_id)
  end
end
