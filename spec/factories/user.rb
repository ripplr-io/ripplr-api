FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.name }
    bio { Faker::GreekPhilosophers.quote }
    slug { name.parameterize }
    level

    after :create do |user|
      create :bookmark_folder, user: user, name: 'Root'
    end
  end
end
