class HashtagsController < ApplicationController
  include Crudable

  def index
    hashtags = Hashtag.search(params[:query])
    read_resource(hashtags)
  end

  def show
    hashtag = Hashtag.find_by!(name: params[:id])
    read_resource(hashtag)
  end
end
