class UsersController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource

  def show
    read_resource(@user)
  end
end
