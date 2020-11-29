class InboxesController < ApplicationController
  include Crudable

  load_and_authorize_resource :post, parent: false, through: :current_user,
    through_association: :push_notification_posts

  def show
    @posts = @posts
      .order(created_at: :desc)
      .page(params[:page])
      .per(params[:per_page])

    read_resource(@posts, included_associations: [:author, :topic, :hashtags, :bookmark])
  end
end
