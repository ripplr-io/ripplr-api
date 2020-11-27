class CommentsController < ApplicationController
  include Crudable

  load_resource :post
  load_and_authorize_resource through: [:post, :comment], shallow: true, except: :show
  authorize_resource only: :show

  def index
    @comments = @comments
      .order(created_at: :desc)
      .page(params[:page])
      .per(params[:per_page])

    read_resource(@comments, included_associations: [:author])
  end

  # TODO: Use cancancan
  def show
    @comments = Comment.find(params[:id]).comments.order(created_at: :desc).page(params[:page]).per(params[:per_page])
    read_resource(@comments, included_associations: [:author])
  end

  # TODO: Use cancancan
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

  def comment_params
    params.permit(:body, :post_id, :comment_id)
  end
end
