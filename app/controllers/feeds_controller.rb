class FeedsController < ApplicationController
  include Crudable

  authorize_resource class: :feed

  # TODO: Use cancancan
  def show
    posts = current_user.following_posts
      .includes(:author, :hashtags, :topic)
      .order(created_at: :desc)
      .page(params[:page])
      .per(params[:per_page])

    read_resource(posts, included_associations: [:author, :topic, :hashtags, :bookmark])
  end
end
