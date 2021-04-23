module Users
  class AnonymizeWorker < ApplicationWorker
    def perform(user_id)
      user = User.only_deleted.find_by(id: user_id)
      return if user.blank?

      user.update!({
        email: "del_#{user.id}@ripplr.io",
        password: SecureRandom.hex,
        avatar: nil,
        timezone: 'UTC',
        country: nil,
        supporter: false
      })

      profile = Profile.only_deleted.find_by(profilable_id: user.id, profilable_type: 'User')
      return if profile.blank?

      profile.update_columns({
        name: 'Deleted Account',
        slug: profile.id,
        bio: ''
      })
    end
  end
end
