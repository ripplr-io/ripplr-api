module Accounts
  class DestroyService < Resources::DestroyService
    def initialize(resource, comment)
      super(resource)
      @comment = comment
    end

    def destroy
      SupportMailer.with(user: @resource, comment: @comment).account_deleted.deliver_later

      success = @resource.destroy
      Users::AnonymizeWorker.perform_async(@resource.id) if success
      success
    end
  end
end
