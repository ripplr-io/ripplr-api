class BookmarksController < ApplicationController
  def index
    data = ActiveModelSerializers::SerializableResource.new(current_user.root_bookmark_folder).as_json
    render json: { data: data }
  end
end
