module Prizes
  class CreateService < Resources::CreateService
    def initialize(attributes)
      super(Prize.new(attributes))
    end

    def save
      success = @resource.save
      Users::UpdateLevelWorker.perform_async(@resource.user.id) if success
      success
    end
  end
end
