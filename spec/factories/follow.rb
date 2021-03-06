FactoryBot.define do
  factory :follow do
    for_topic
    user

    trait :for_user do
      followable factory: :user
    end

    trait :for_profile do
      followable factory: :profile
    end

    trait :for_topic do
      followable factory: :topic
    end

    trait :for_hashtag do
      followable factory: :hashtag
    end

    trait :for_community do
      followable factory: :community
    end
  end
end
