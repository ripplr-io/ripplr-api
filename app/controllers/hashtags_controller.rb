class HashtagsController < ApplicationController
  include Crudable

  authorize_resource only: :index
  load_and_authorize_resource only: :show, find_by: :name

  def index
    @hashtags = Hashtag.search(params[:query])
    read_resource(@hashtags)
  end

  def show
    read_resource(@hashtag)
  end
end
