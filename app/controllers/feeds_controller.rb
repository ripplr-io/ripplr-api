class FeedsController < ApplicationController
  include Crudable

  load_and_authorize_resource :post, parent: false, through: :current_user, through_association: :following_posts

  def show
    @posts = @posts
      .includes(:author, :hashtags, :topic)
      .order(created_at: :desc)
      .page(params[:page])
      .per(params[:per_page])

    read_resource(@posts, included_associations: [:author, :topic, :hashtags, :bookmark])
  end
end
