FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.name }
    bio { Faker::GreekPhilosophers.quote }
    avatar { 'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png' }
    slug { name.parameterize }
  end
end
