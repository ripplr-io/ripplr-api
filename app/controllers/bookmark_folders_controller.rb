class BookmarkFoldersController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!
  before_action :find_bookmark_folder, only: [:update, :destroy]

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
