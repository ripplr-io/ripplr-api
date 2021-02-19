class InboxItemsController < ApplicationController
  include JsonApi::Crudable

  load_resource :inbox
  load_and_authorize_resource through: [:inbox]

  serializer include: [:inboxable, 'inboxable.author', 'inboxable.topic', 'inboxable.hashtags', 'inboxable.bookmark']

  def index
    @inbox_items = @inbox_items.archived(false) if hide_archived?
    @inbox_items = @inbox_items
      .includes(:inboxable)
      .order(created_at: :desc)
      .page(params[:page])
      .per(params[:per_page])

    read_resource(@inbox_items)
  end

  private

  def hide_archived?
    !params[:include_archived]
  end
end
