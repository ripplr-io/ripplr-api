class CommentsController < ApplicationController
  def index
    data = ActiveModelSerializers::SerializableResource.new(find_comments).as_json
    render json: { data: data }
  end

  private

  def find_comments
    return Post.find(params[:post_id]).comments if params[:post_id].present?
  end
end
