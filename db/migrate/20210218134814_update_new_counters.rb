class UpdateNewCounters < ActiveRecord::Migration[6.1]
  def change
    InboxItem.counter_culture_fix_counts
    SubscriptionInbox.counter_culture_fix_counts
  end
end
