class HashtagsController < ApplicationController
  include Crudable

  load_and_authorize_resource find_by: :name
  skip_load_resource only: :index

  def index
    @hashtags = Hashtag.search(params[:query])
    read_resource(@hashtags)
  end

  def show
    read_resource(@hashtag)
  end
end
