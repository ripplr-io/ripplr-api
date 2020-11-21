class SubscriptionSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  attributes :subscribable_id, :settings, :created_at, :updated_at

  # FIXME: this is not polymorphic
  belongs_to :subscribable, record_type: :user, serializer: :user

  attribute :subscribable_type do |object|
    object.subscribable_type.downcase
  end
end
