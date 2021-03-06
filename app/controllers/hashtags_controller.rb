class HashtagsController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource
  skip_load_resource only: :index

  def index
    @hashtags = Hashtag.search(params[:query])
      .page(params[:page])
      .per(params[:per_page])
    read_resource(@hashtags)
  end

  def show
    read_resource(@hashtag)
  end
end
