class FeedsController < ApplicationController
  def show
    posts = current_user.following_posts.page(params[:page]).per(params[:per_page])
    data = ActiveModelSerializers::SerializableResource.new(posts).as_json
    render json: { data: data }
  end
end
