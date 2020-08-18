class FollowsController < ApplicationController
  def index
    data = ActiveModelSerializers::SerializableResource.new(find_follows).as_json
    render json: { data: data }
  end

  def create
    current_user.follows.create!(followable_id: params[:followable_id], followable_type: params[:followable_type].capitalize)
  end

  private

  def find_follows
    current_user.follows
  end

  def follow_params
    params.require(:follow).permit(:followable_id, :followable_type)
  end
end
