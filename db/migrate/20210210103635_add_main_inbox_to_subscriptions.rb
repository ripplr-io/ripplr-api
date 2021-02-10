class AddMainInboxToSubscriptions < ActiveRecord::Migration[6.1]
  def up
    Subscription.all.each do |subscription|
      subscription.inboxes = [subscription.user.inboxes.find_by(name: 'Main Inbox')]
    end
  end
end
