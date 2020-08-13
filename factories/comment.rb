FactoryBot.define do
  factory :comment do
    author factory: :user
    post

    body { Faker::Lorem.paragraph }
  end
end
