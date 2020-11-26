class CommentsController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!, only: :create
  before_action :find_comment, only: [:update, :destroy]

  def index
    @comments = Post.find(params[:post_id]).comments.order(created_at: :desc).page(params[:page]).per(params[:per_page])
    read_resource(@comments, included_associations: [:author])
  end

  def show
    @comments = Comment.find(params[:id]).comments.order(created_at: :desc).page(params[:page]).per(params[:per_page])
    read_resource(@comments, included_associations: [:author])
  end

  def create
    @comment = Comments::CreateService.new(comment_params.merge(author: current_user))
    create_resource(@comment, included_associations: [:author])
  end

  def update
    @comment.assign_attributes(comment_params)
    update_resource(@comment, included_associations: [:author])
  end

  def destroy
    destroy_resource(@comment)
  end

  private

  def find_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.permit(:body, :post_id, :comment_id)
  end
end
