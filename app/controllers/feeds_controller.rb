class FeedsController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!

  def show
    posts = current_user.following_posts
      .includes(:author, :hashtags, :topic)
      .order(created_at: :desc)
      .page(params[:page])
      .per(params[:per_page])

    read_resource(posts, included_associations: [:author, :topic, :hashtags])
  end
end
