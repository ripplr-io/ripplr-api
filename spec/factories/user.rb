FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.name }
    bio { Faker::GreekPhilosophers.quote }
    billing { association :billing, user: instance }
    level

    bookmark_folders do
      [
        association(:bookmark_folder, user: instance, name: 'Root')
      ]
    end
  end
end
