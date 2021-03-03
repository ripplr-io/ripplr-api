module InboxItems
  class ArchiveController < ApplicationController
    include JsonApi::Crudable

    load_and_authorize_resource :inbox_item

    serializer class: InboxItemSerializer, include: [:inboxable]

    def update
      @inbox_item.assign_attributes(archive_params)
      update_resource(@inbox_item, interactor: InboxItems::UpdateArchive)
    end

    private

    def archive_params
      timestamp = params[:status] == 'false' ? nil : Time.current

      { archived_at: timestamp }
    end
  end
end
