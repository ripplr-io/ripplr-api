class LevelsController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource

  def index
    read_resource(@levels)
  end
end
