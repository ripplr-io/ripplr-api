class CommentsController < ApplicationController
  include JsonApi::Crudable

  load_resource :post
  load_and_authorize_resource through: :post, shallow: true

  serializer include: [:profile]

  def index
    @comments = @comments
      .order(created_at: :desc)
      .page(params[:page])
      .per(params[:per_page])

    read_resource(@comments)
  end

  def show
    @comments = @comment.comments
      .order(created_at: :desc)
      .page(params[:page])
      .per(params[:per_page])

    read_resource(@comments)
  end

  def create
    create_resource(@comment, interactor: Comments::Create)
  end

  def update
    @comment.assign_attributes(comment_params)
    update_resource(@comment)
  end

  def destroy
    destroy_resource(@comment)
  end

  private

  def comment_params
    params.permit(:body, :comment_id)
  end
end
