module Prizes
  class Create < ApplicationInteractor
    def call
      context.fail! unless context.resource.save

      Users::UpdateLevelWorker.perform_async(context.resource.user.id)
    end
  end
end
