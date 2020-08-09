class UsersController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def legacy_show
    redirect_to "/auth/users/#{current_user.id}"
  end

  def show
    data = ActiveModelSerializers::SerializableResource.new(User.first).as_json
    render json: { data: data }
  end

  def create; end

  def update; end

  def destroy; end
end
