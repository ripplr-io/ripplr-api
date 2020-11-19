class RatingSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  attributes :points, :ratable_id, :ratable_type, :created_at
end
