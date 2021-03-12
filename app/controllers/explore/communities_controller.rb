module Explore
  class CommunitiesController < ApplicationController
    include JsonApi::Crudable

    load_and_authorize_resource

    def index
      @communities = @communities.where.not(id: current_user.following_communities.ids) if current_user.present?

      @communities = @communities
        .order(posts_count: :desc)
        .page(params[:page])
        .per(params[:per_page])

      read_resource(@communities)
    end
  end
end
