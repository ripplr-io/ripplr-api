class UsersController < ApplicationController
  include Crudable

  def show
    read_resource(find_user)
  end

  private

  def find_user
    User.friendly.find(params[:id])
  end
end
