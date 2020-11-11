module Users
  class AnonymizeWorker
    include Sidekiq::Worker

    def perform(user_id)
      user = User.only_deleted.find_by(id: user_id)
      return if user.blank?

      user.update!({
        email: "#{user.id}@disabled.com",
        password: SecureRandom.hex,
        name: 'Disabled Account',
        bio: nil,
        avatar: nil,
        timezone: 'UTC',
        country: nil,
        supporter: false
      })
    end
  end
end
