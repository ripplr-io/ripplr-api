class PostsController < ApplicationController
  include JsonApi::Crudable

  load_resource :user
  load_resource :topic
  load_resource :hashtag, find_by: :name
  load_resource :inbox
  load_and_authorize_resource through: [:user, :topic, :hashtag, :inbox], shallow: true

  serializer include: [:author, :topic, :hashtags, :bookmark]

  def index
    @posts =
      case params[:sort_by]
      when 'popularity'
        @posts.order_by_popularity
      else
        @posts.order_chronologically
      end

    @posts = @posts
      .page(params[:page])
      .per(params[:per_page])

    read_resource(@posts)
  end

  def show
    read_resource(@post)
  end

  def create
    create_resource(@post, interactor: Posts::Create, context: create_context)
  end

  def update
    @post.assign_attributes(post_params)
    update_resource(@post)
  end

  def destroy
    destroy_resource(@post)
  end

  private

  def post_params
    params.permit(:title, :body, :url, :topic_id).merge(hashtag_params).merge(image_params)
  end

  def hashtag_params
    return {} if params[:hashtags].blank?

    hashtags = JSON.parse(params[:hashtags]).map do |value|
      Hashtag.find_or_create_by(name: value)
    end

    { hashtags: hashtags }
  end

  def image_params
    return {} if params[:image_file].blank?
    return {} if params[:image_file] == 'undefined' # FIXME: in the frontend

    { image: params[:image_file] }
  end

  def create_context
    { image_url: params[:image] }
  end
end
