class LevelsController < ApplicationController
  wrap_parameters :post

  def index
    data = ActiveModelSerializers::SerializableResource.new(Posts.all).as_json
    render json: { data: data }
  end

  def show
    data = ActiveModelSerializers::SerializableResource.new(Post.find(id)).as_json
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

  def post_params
    params.require(:post).permit(:title, :body, :image, :url)
  end
end
