class SubscriptionSerializer < ApplicationSerializer
  belongs_to :subscribable, polymorphic: true
  has_many :inboxes

  attributes :settings, :created_at, :updated_at
end
