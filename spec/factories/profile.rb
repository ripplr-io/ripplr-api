FactoryBot.define do
  factory :profile do
    name { Faker::Name.name }
    bio { Faker::GreekPhilosophers.quote }
    for_user

    trait :for_user do
      after :build do |object|
        object.profilable ||= build(:user, profile: object)
      end
    end
  end
end
