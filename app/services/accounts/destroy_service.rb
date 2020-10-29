module Accounts
  class DestroyService < Resources::DestroyService
    def initialize(resource, comment)
      super(resource)
      @comment = comment
    end

    def destroy
      success = @resource.destroy
      SupportMailer.with(user: @resource, comment: @comment).account_deleted.deliver_later if success
      success
    end
  end
end
