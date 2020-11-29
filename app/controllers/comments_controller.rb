class CommentsController < ApplicationController
  include Crudable

  load_resource :post
  load_and_authorize_resource through: :post, shallow: true

  def index
    @comments = @comments
      .order(created_at: :desc)
      .page(params[:page])
      .per(params[:per_page])

    read_resource(@comments, included_associations: [:author])
  end

  def show
    @comments = @comment.comments
      .order(created_at: :desc)
      .page(params[:page])
      .per(params[:per_page])

    read_resource(@comments, included_associations: [:author])
  end

  def create
    @comment = Comments::CreateService.new(@comment)
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
    params.permit(:body, :comment_id)
  end
end
