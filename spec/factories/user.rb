FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    profile { association :profile, profilable: instance }
    billing { association :billing, user: instance }
    level
  end
end
