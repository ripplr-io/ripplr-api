class CommentsController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!, only: :create

  def index
    @comments = Post.find(params[:post_id]).comments
    read_resource(@comments, included_associations: [:author])
  end

  def show
    @comments = Comment.find(params[:id]).comments
    read_resource(@comments, included_associations: [:author])
  end

  def create
    @comment = Comments::CreateService.new(comment_params.merge!(author: current_user))
    create_resource(@comment, included_associations: [:author])
  end

  private

  def comment_params
    params.permit(:body, :post_id, :comment_id)
  end
end
