module Prizes
  class CreateService < Resources::BaseService
    def save
      success = @resource.save
      Users::UpdateLevelWorker.perform_async(@resource.user.id) if success
      success
    end
  end
end
