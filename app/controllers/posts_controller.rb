class PostsController < ApplicationController
  wrap_parameters :post

  def index
    @user = User.friendly.find(params[:id])
    data = ActiveModelSerializers::SerializableResource.new(@user.posts).as_json
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
