class SubscriptionInboxSerializer < ApplicationSerializer
  attributes :created_at, :updated_at

  belongs_to :inbox
  belongs_to :subscription
end
