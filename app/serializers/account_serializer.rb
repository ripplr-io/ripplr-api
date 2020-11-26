class AccountSerializer < UserSerializer
  set_type :user
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  belongs_to :level

  attribute :onboarded_at

  attribute :accountInfo do |object|
    {
      email: object.email,
      country: object.country,
      timezone: object.timezone,
      postsToday: object.posts_today
    }
  end
end
