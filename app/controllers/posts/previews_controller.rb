module Posts
  class PreviewsController < ApplicationController
    authorize_resource class: Post

    def create
      data = Linkpreview::FetchPreviewService.new(params[:url]).call
      render json: { data: data }, status: :ok
    end
  end
end
