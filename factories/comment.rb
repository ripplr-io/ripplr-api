FactoryBot.define do
  factory :comment do
    author factory: :user
    post
    comment { nil }

    body { Faker::Hipster.paragraph }
  end

  factory :reply, parent: :comment do
    comment
    post { nil }
  end
end
