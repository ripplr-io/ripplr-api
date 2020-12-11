module Accounts
  class UpdateMarketingService < Resources::BaseService
    def save
      success = @resource.save
      Sendgrid::SyncUserWorker.perform_async(@resource.id) if success
      success
    end
  end
end
