class AddOnboardedTimestampsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :onboarding_started_at, :datetime
    add_column :users, :onboarding_finished_at, :datetime

    User.all.each do |user|
      user.update(onboarding_started_at: user.onboarded_at)
    end
  end
end
