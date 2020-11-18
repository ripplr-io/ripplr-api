class SubscriptionSerializer < ApplicationSerializer
  attributes :subscribable_id, :settings, :created_at, :updated_at

  # TODO: Fix this - it's not polymorphic
  belongs_to :subscribable, record_type: :user, serializer: :user

  attribute :subscribable_type do |object|
    object.subscribable_type.downcase
  end
end
