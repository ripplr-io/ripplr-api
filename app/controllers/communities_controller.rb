class CommunitiesController < ApplicationController
  include JsonApi::Crudable

  before_action :rename_params

  load_resource :topic
  load_and_authorize_resource through: [:topic], shallow: true

  def index
    @communities = @communities
      .order(posts_count: :desc)
      .page(params[:page])
      .per(params[:per_page])

    read_resource(@communities)
  end

  def show
    read_resource(@community)
  end

  def create
    create_resource(@community, interactor: Communities::Create)
  end

  def update
    @community.assign_attributes(community_params)
    update_resource(@community)
  end

  def destroy
    destroy_resource(@community)
  end

  private

  # FIXME: Remove after this has been renamed in the frontend
  def rename_params
    params[:avatar] = params.delete(:avatar_file)
  end

  def topic_params
    return {} if params[:topic_ids].blank?

    { topics: Topic.where(id: JSON.parse(params[:topic_ids])) }
  end

  def community_params
    params.permit(:name, :description, :avatar).merge(topic_params)
  end
end
