class CommunitiesController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource

  def show
    read_resource(@community)
  end

  def create
    create_resource(@community)
  end

  def update
    @community.assign_attributes(community_params)
    update_resource(@community)
  end

  def destroy
    destroy_resource(@community)
  end

  private

  def topic_params
    return {} if params[:topic_ids].blank?

    { topics: Topic.where(id: JSON.parse(params[:topic_ids])) }
  end

  def community_params
    params.permit(:name, :description, :image).merge(topic_params)
  end
end
