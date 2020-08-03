class LevelsController < ApplicationController
  def index
    data = ActiveModelSerializers::SerializableResource.new(Level.all).as_json
    render json: {data: data}
  end
end
