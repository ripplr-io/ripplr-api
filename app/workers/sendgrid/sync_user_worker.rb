module Sendgrid
  class SyncUserWorker < ApplicationWorker
    def perform(user_id)
      user = User.find_by(id: user_id)
      return if user.blank?

      Sendgrid::BaseService.new.sync_user(user)
    end
  end
end
