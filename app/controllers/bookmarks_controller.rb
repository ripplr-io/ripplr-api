class BookmarksController < ApplicationController
  def index
    data = ActiveModelSerializers::SerializableResource.new(current_user.root_bookmark_folder).as_json
    render json: { data: data }
  end

  def create
    current_user.bookmark_folders.find(params[:bookmark_folder_id]).bookmarks.create!(bookmark_params)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:post_id, :bookmark_folder_id)
  end
end
