class AccountSerializer < ApplicationSerializer
  set_type :user

  belongs_to :level
  belongs_to :profile

  attributes :onboarded_at, :onboarding_started_at, :onboarding_finished_at, :subscribed_to_marketing
  attribute :pointsSum, &:total_points

  attribute :avatar do |object|
    url_helpers.public_blob_url(object.profile.avatar) if object.profile.avatar.attached?
  end

  attribute :name do |object|
    object.profile.name
  end

  attribute :slug do |object|
    object.profile.slug
  end

  attribute :bio do |object|
    object.profile.bio
  end

  attribute :postsCount do |object|
    object.profile.posts_count
  end

  attribute :accountInfo do |object|
    {
      email: object.email,
      country: object.country,
      timezone: object.timezone
    }
  end

  attribute :onboarding_prizes do |object|
    names = Prize::ONBOARDING_PRIZES.values.pluck(:name)
    account_prizes = object.prizes.where(name: names).pluck(:name)

    data = {}
    Prize::ONBOARDING_PRIZES.each do |key, value|
      data[key] = account_prizes.include? value[:name]
    end

    data
  end
end
