class UsersController < ApplicationController
  def show
    render json: find_user
  end

  private

  def find_user
    User.friendly.find(params[:id])
  end
end
