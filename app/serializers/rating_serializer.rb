class RatingSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  belongs_to :ratable, polymorphic: true

  attributes :points, :created_at
end
