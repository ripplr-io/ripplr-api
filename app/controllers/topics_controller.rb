class TopicsController < ApplicationController
  include Crudable

  def index
    topics = Topic.all.order(name: :asc)
    read_resource(topics)
  end
end
