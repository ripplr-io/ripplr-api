class AddSubscribedToMarketingToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :subscribed_to_marketing, :boolean, null: false, default: false
  end
end
