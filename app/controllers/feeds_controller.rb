class FeedsController < ApplicationController
  def show
    data = ActiveModelSerializers::SerializableResource.new(current_user.following_posts).as_json
    render json: { data: data }
  end
end
