class CopyUserFollowsToProfile < ActiveRecord::Migration[6.1]
  def change
    Follow.where(followable_type: 'User').each do |follow|
      Follow.create(user: follow.user, followable: follow.followable.profile)
    end
  end
end
