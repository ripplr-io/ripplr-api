FactoryBot.define do
  factory :comment do
    author factory: :user
    post
    comment { nil }

    body { Faker::Lorem.paragraph }
  end

  factory :reply, parent: :comment do
    comment
  end
end
