class CopyAttributesFromUserToProfile < ActiveRecord::Migration[6.1]
  def up
    User.all.each do |user|
      next if user.profile.present?

      user.create_profile(
        name: user.name,
        slug: user.slug,
        bio: user.bio
      )

      user.profile.avatar.attach(user.avatar.blob)
    end
  end
end
