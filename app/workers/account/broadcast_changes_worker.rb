module Account
  class BroadcastChangesWorker < ApplicationWorker
    def perform(user_id)
      user = User.find_by(id: user_id)
      return if user.blank?

      data = {
        type: :account_changes,
        payload: AccountSerializer.new(user, { include: [:profile, :level] }).serializable_hash
      }

      UserChannel.broadcast_to(user, data)
    end
  end
end
