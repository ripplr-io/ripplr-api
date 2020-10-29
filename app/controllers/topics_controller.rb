class TopicsController < ApplicationController
  include Crudable

  def index
    read_resource(Topic.all)
  end
end
