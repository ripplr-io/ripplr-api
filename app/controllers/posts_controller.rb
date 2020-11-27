class PostsController < ApplicationController
  include Crudable

  load_resource :user
  load_resource :topic
  load_resource :hashtag, find_by: :name
  load_and_authorize_resource through: [:user, :topic, :hashtag], shallow: true

  def index
    @posts = @posts
      .order(created_at: :desc)
      .page(params[:page])
      .per(params[:per_page])

    read_resource(@posts, included_associations: [:author, :topic, :hashtags, :bookmark])
  end

  def show
    read_resource(@post, included_associations: [:author, :topic, :hashtags, :bookmark])
  end

  # TODO: Use cancancan
  def create
    @post = Posts::CreateService.new(post_params.merge(author: current_user), image_url: params[:image])
    create_resource(@post, included_associations: [:author, :topic, :hashtags, :bookmark])
  end

  def update
    @post.assign_attributes(post_params)
    update_resource(@post)
  end

  def destroy
    destroy_resource(@post)
  end

  # TODO: Extract to its own controller
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
end
