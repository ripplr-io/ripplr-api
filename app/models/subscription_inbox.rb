class SubscriptionInbox < ApplicationRecord
  belongs_to :subscription
  belongs_to :inbox
end
