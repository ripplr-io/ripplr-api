module Posts
  class PreviewsController < ApplicationController
    authorize_resource class: Post

    def create
      service = Posts::PreviewService.new(params[:url])
      render json: { data: service.data }, status: :ok
    end
  end
end
