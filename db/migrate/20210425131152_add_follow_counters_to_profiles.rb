class AddFollowCountersToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :following_profiles_count, :integer, null: false, default: 0
    add_column :profiles, :followers_count, :integer, null: false, default: 0
  end
end
