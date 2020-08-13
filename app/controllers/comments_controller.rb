class CommentsController < ApplicationController
  def index
    data = ActiveModelSerializers::SerializableResource.new(find_comments).as_json
    render json: { data: data }
  end

  def show
    data = ActiveModelSerializers::SerializableResource.new(find_comments).as_json
    render json: { data: data }
  end

  # TODO: Improve responses
  def create
    current_user.comments.create!(comment_params)
  end

  private

  def find_comments
    return Comment.find(params[:id]).comments if params[:id].present?
    return Post.find(params[:post_id]).comments if params[:post_id].present?
  end

  def comment_params
    params.require(:comment).permit(:body, :post_id, :comment_id)
  end
end
