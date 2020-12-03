module Posts
  class PreviewsController < ApplicationController
    authorize_resource class: Post

    def create
      page = MetaInspector.new(params[:url] || '')
      raise MetaInspector::RequestError unless page.response.status == 200
    rescue MetaInspector::TimeoutError, MetaInspector::RequestError, MetaInspector::ParserError
      render json: { data: data_for_error }, status: :ok
    else
      render json: { data: data_for_page(page) }, status: :ok
    end

    private

    def data_for_error
      {
        url: params[:url] || ''
      }
    end

    def data_for_page(page)
      {
        title: page.best_title,
        body: page.best_description,
        image: page.images.best,
        url: page.url
      }
    end
  end
end
