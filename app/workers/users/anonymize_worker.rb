module Users
  class AnonymizeWorker < ApplicationWorker
    def perform(user_id)
      user = User.only_deleted.find_by(id: user_id)
      return if user.blank?

      user.update!({
        email: "del_#{user.id}@ripplr.io",
        password: SecureRandom.hex,
        name: 'Deleted Account',
        bio: nil,
        avatar: nil,
        timezone: 'UTC',
        country: nil,
        supporter: false
      })
    end
  end
end
