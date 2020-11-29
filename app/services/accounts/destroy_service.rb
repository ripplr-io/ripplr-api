module Accounts
  class DestroyService < Resources::BaseService
    def initialize(resource, comment)
      super(resource)
      @comment = comment
    end

    def destroy
      SupportMailer.account_deleted(@resource, @comment).deliver_later

      success = @resource.destroy
      Users::AnonymizeWorker.perform_async(@resource.id) if success
      success
    end
  end
end
