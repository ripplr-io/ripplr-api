class AddOnboardedTimestampsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :onboarding_started_at, :datetime
    add_column :users, :onboarding_finished_at, :datetime
  end
end
