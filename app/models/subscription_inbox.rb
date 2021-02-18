class SubscriptionInbox < ApplicationRecord
  belongs_to :subscription
  belongs_to :inbox

  counter_culture :inbox, touch: true
end
