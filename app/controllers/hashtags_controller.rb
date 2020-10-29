class HashtagsController < ApplicationController
  include Crudable

  def show
    hashtag = Hashtag.find_by!(name: params[:id])
    read_resource(hashtag)
  end
end
