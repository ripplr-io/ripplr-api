class SubscriptionSerializer < ApplicationSerializer
  belongs_to :subscribable, polymorphic: true

  attributes :settings, :created_at, :updated_at
end
