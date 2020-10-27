class CommentsController < ApplicationController
  include Crudable

  before_action :authenticate_user!, only: :create

  def index
    @comments = Post.find(params[:post_id]).comments
    render json: @comments, include: [:author]
  end

  def show
    @comments = Comment.find(params[:id]).comments
    render json: @comments, include: [:author]
  end

  def create
    @comment = current_user.comments.new(comment_params)
    create_resource(@comment, included_associations: [:author])
  end

  private

  def comment_params
    params.permit(:body, :post_id, :comment_id)
  end
end
