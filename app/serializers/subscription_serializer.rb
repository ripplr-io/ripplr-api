class SubscriptionSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  belongs_to :subscribable, polymorphic: true

  attributes :settings, :created_at, :updated_at

  # FIXME: Legacy attributes - remove
  attribute :subscribable_id
  attribute :subscribable_type do |object|
    object.subscribable_type.downcase
  end
end
