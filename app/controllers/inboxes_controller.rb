class InboxesController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource :post, parent: false, through: :current_user,
    through_association: :push_notification_posts

  serializer include: [:author, :topic, :hashtags, :bookmark]

  def show
    @posts = @posts
      .order(created_at: :desc)
      .page(params[:page])
      .per(params[:per_page])

    read_resource(@posts)
  end
end
