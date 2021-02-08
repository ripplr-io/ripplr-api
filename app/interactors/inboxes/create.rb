module Inboxes
  class Create < ApplicationInteractor
    before :check_limit_reached

    def call
      context.fail! unless context.resource.save

      Mixpanel::TrackInboxCreatedWorker.perform_async(context.resource.id)
    end

    private

    def check_limit_reached
      return unless above_level_limit?

      context.resource.errors.add(:max_inboxes, 'limit reached')
      context.fail!
    end

    def above_level_limit?
      context.resource.user.inboxes.count >= context.resource.user.level.inboxes
    end
  end
end
