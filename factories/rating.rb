FactoryBot.define do
  factory :rating do
    for_post
    user
    points { [1, 2, 3, 5, 8].sample }

    trait :for_post do
      ratable factory: :post
    end

    trait :for_comment do
      ratable factory: :comment
    end

    trait :for_reply do
      ratable factory: :reply
    end
  end
end
