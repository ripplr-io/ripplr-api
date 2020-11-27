class UsersController < ApplicationController
  include Crudable

  load_and_authorize_resource

  def show
    read_resource(@user)
  end
end
