module Posts
  class PreviewsController < ApplicationController
    authorize_resource class: Post

    def create
      data = LinkPreview.fetch(params[:url])
      render json: { data: data }, status: :ok
    end
  end
end
