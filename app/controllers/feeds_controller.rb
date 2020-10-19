class FeedsController < ApplicationController
  before_action :authenticate_user!

  def show
    posts = current_user.following_posts.page(params[:page]).per(params[:per_page])
    render json: posts, include: [:author, :topic, :hashtags]
  end
end
