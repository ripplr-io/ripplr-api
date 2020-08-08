class TopicsController < ApplicationController
  def index
    data = ActiveModelSerializers::SerializableResource.new(Topic.all).as_json
    render json: { data: data }
  end
end
