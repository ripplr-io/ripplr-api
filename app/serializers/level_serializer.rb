class LevelSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  attributes :name, :from, :to, :posts, :referrals, :subscriptions
end
