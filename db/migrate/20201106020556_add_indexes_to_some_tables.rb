class AddIndexesToSomeTables < ActiveRecord::Migration[6.0]
  def change
    # A post cannot have the same hashtag multiple times
    add_index :post_hashtags, [:post_id, :hashtag_id], unique: true

    # A user cannot rate the same resource multiple times
    add_index :ratings, [:user_id, :ratable_id, :ratable_type], unique: true

    # A user cannot follow the same resource multiple times
    add_index :follows, [:user_id, :followable_id, :followable_type], unique: true

    # A user cannot subscribe the same resource multiple times
    add_index :subscriptions, [:user_id, :subscribable_id, :subscribable_type], unique: true,
      name: 'ux_subscriptions_user_subscribable'

    # A folder cannot contain two subfolders with the same name
    add_index :bookmark_folders, [:bookmark_folder_id, :user_id, :name], unique: true,
      name: 'ux_bookmark_folders_bookmark_folder_user_name'

    # A user cannot have two devices with the same name
    add_index :devices, [:user_id, :name], unique: true

    # A device cannot receive the same push notification multiple times
    add_index :push_notifications, [:post_id, :device_id], unique: true

    # A user cannot invite the same email twice
    add_index :referrals, [:inviter_id, :email], unique: true

    # A referral cannot have the inviter/invitee combination multiple times
    add_index :referrals, [:inviter_id, :invitee_id], unique: true, where: 'invitee_id IS NOT NULL'
  end
end
