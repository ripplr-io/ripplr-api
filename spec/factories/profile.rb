FactoryBot.define do
  factory :profile do
    name { Faker::Name.name }
    bio { Faker::GreekPhilosophers.quote }
    for_user

    trait :for_user do
      profilable { association :user, profile: instance }
    end
  end
end
