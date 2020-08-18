class HashtagsController < ApplicationController
  def show
    hashtag = Hashtag.find_by(name: params[:id])
    data = ActiveModelSerializers::SerializableResource.new(hashtag).as_json
    render json: { data: data }
  end
end
