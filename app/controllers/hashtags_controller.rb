class HashtagsController < ApplicationController
  def show
    hashtag = Hashtag.find_by!(name: params[:id])
    render json: hashtag
  end
end
