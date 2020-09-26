class BookmarkFoldersController < ApplicationController
  def create
    current_user.bookmark_folders.create!(folder_params)
  end

  def update
    current_user.bookmark_folders.find(params[:id]).update!(folder_params)
  end

  def destroy
    current_user.bookmark_folders.find(params[:id]).destroy!
  end

  private

  def folder_params
    params.require(:bookmark_folder).permit(:name, :bookmark_folder_id)
  end
end
