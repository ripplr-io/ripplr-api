class CopySubscriptions < ActiveRecord::Migration[6.1]
  def up
    Subscription.where(subscribable_type: 'User').each do |subscription|
      subscription.update(subscribable: subscription.subscribable.profile)
    end
  end
end
