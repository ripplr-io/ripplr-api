class FollowersController < ApplicationController
  include JsonApi::Crudable

  load_resource :user
  load_and_authorize_resource :user, parent: false, through: :user, through_association: :followers

  def index
    read_resource(@users)
  end
end
