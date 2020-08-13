FactoryBot.define do
  factory :comment do
    author factory: :user
    post
    parent { nil }

    body { Faker::Lorem.paragraph }
  end

  factory :reply, parent: :comment do
    parent factory: :comment
  end
end
