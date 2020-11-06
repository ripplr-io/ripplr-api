class InboxesController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!

  def show
    posts = current_user.push_notification_posts.order(created_at: :desc).page(params[:page]).per(params[:per_page])
    read_resource(posts)
  end
end
