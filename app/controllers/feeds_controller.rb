class FeedsController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource :post, parent: false, through: :current_user, through_association: :following_posts

  serializer include: [:author, :topic, :hashtags, :bookmark, :communities]

  def show
    @posts = @posts
      .includes(:author, :hashtags, :topic, :communities)
      .order(created_at: :desc)
      .page(params[:page])
      .per(params[:per_page])

    read_resource(@posts)
  end
end
