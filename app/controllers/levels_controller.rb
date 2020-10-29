class LevelsController < ApplicationController
  include Crudable

  def index
    read_resource(Level.all)
  end
end
