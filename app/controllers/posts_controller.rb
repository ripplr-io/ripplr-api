class PostsController < ApplicationController
  include JsonApi::Crudable

  before_action :rename_params

  load_resource :user, only: :index
  load_resource :topic, only: :index
  load_resource :hashtag, only: :index, find_by: :name
  load_resource :community, only: :index
  load_and_authorize_resource through: [:user, :topic, :hashtag, :community], shallow: true

  serializer include: [:author, :topic, :hashtags, :bookmark, :communities]

  def index
    @posts =
      case params[:sort_by]
      when 'popularity'
        @posts.order_by_trending
      when 'rating'
        @posts.order_by_rating
      else
        @posts.order_chronologically
      end

    @posts = @posts
      .includes(:author, :topic, :hashtags, :communities)
      .page(params[:page])
      .per(params[:per_page])

    read_resource(@posts)
  end

  def show
    read_resource(@post)
  end

  def create
    create_resource(@post, interactor: Posts::Create)
  end

  def update
    # TODO: This (create_params) is a temporary solution to allow people to set communities right
    # after the feature was lauched and should be removed in the future
    @post.assign_attributes(create_params)
    update_resource(@post)
  end

  def destroy
    destroy_resource(@post)
  end

  private

  # FIXME: This can be removed once the names change in the frontend
  def rename_params
    params[:image_url] = params.delete(:image)

    image_file = params.delete(:image_file)
    # FIXME: make sure the frontend only sends an image_file when it expects to make changes to it
    params[:image] = image_file if image_file.present? && image_file != 'undefined'
  end

  def post_params
    params.permit(:title, :body, :image, :image_url).merge(hashtag_params)
  end

  def create_params
    post_params.merge(params.permit(:url, :topic_id)).merge(community_params)
  end

  def hashtag_params
    return {} if params[:hashtags].blank?

    hashtags = JSON.parse(params[:hashtags]).map do |value|
      Hashtag.find_or_create_by(name: value)
    end

    { hashtags: hashtags }
  end

  def community_params
    return {} if params[:community_ids].blank?

    { communities: Community.where(id: JSON.parse(params[:community_ids])) }
  end
end
