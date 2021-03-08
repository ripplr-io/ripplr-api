FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.name }
    bio { Faker::GreekPhilosophers.quote }
    slug { name.parameterize }
    billing { association :billing, user: instance }
    level

    bookmark_folders do
      [
        build(:bookmark_folder, user: instance, name: 'Root')
      ]
    end
  end
end
