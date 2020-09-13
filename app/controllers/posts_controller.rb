class PostsController < ApplicationController
  wrap_parameters :post

  def index
    data = ActiveModelSerializers::SerializableResource.new(find_paginated_posts).as_json
    render json: { data: data }
  end

  # TODO: Implement answers and error handling
  def create
    Post.create(post_params)
  end

  def update
    Post.find(params[:id]).update(post_params)
  end

  def destroy
    Post.find(params[:id]).destroy
  end

  private

  def find_posts
    return User.friendly.find(params[:user_id]).posts if params[:user_id].present?
    return Topic.friendly.find(params[:topic_id]).posts if params[:topic_id].present?
    return Hashtag.find_by(name: params[:hashtag_id]).posts if params[:hashtag_id].present?
  end

  def find_paginated_posts
    find_posts.page(params[:page]).per(params[:per_page])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image, :url)
  end
end