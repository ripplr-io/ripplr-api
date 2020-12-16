class TopicsController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource

  def index
    @topics = @topics.order(name: :asc)
    read_resource(@topics)
  end
end
