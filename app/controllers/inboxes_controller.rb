class InboxesController < ApplicationController
  include Crudable

  load_and_authorize_resource class: :inbox

  # TODO: Use cancancan
  def show
    posts = current_user.push_notification_posts.order(created_at: :desc).page(params[:page]).per(params[:per_page])
    read_resource(posts, included_associations: [:author, :topic, :hashtags, :bookmark])
  end
end
