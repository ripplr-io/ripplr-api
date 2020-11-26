class SubscriptionSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  belongs_to :subscribable, polymorphic: true

  attributes :settings, :created_at, :updated_at
end
