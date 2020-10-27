class PostsController < ApplicationController
  include Crudable

  before_action :authenticate_user!, except: :index
  before_action :find_post, only: [:update, :destroy]

  def index
    render json: find_paginated_posts, include: [:author, :topic, :hashtags]
  end

  def show
    @post = Post.find(params[:id])
    render json: @post, include: [:author, :topic, :hashtags]
  end

  def create
    @post = current_user.posts.new(post_params)
    create_resource(@post)
  end

  def update
    @post.assign_attributes(post_params)
    update_resource(@post)
  end

  def destroy
    destroy_resource(@post)
  end

  def preview
    page = MetaInspector.new(params[:url])
    return render json: { status: 404 } if page.response.status != 200

    render json: {
      status: 'success',
      data: {
        title: page.best_title,
        body: page.best_description,
        image: page.images.best,
        url: page.url
      }
    }
  end

  private

  def find_posts
    if params[:user_id].present?
      User.friendly.find(params[:user_id]).posts
    elsif params[:topic_id].present?
      Topic.friendly.find(params[:topic_id]).posts
    elsif params[:hashtag_id].present?
      Hashtag.find_by(name: params[:hashtag_id]).posts
    end
  end

  def find_paginated_posts
    find_posts.page(params[:page]).per(params[:per_page])
  end

  def find_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.permit(:title, :body, :image, :url, :topic_id)
  end
end
