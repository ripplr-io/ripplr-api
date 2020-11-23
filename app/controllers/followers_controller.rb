class FollowersController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!

  def index
    read_resource(current_user.followers)
  end
end
