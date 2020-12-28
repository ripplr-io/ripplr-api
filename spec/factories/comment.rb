FactoryBot.define do
  factory :base_comment, class: 'Comment' do
    author factory: :user
    body { Faker::Hipster.paragraph }
  end

  factory :reply, parent: :base_comment do
    comment
    post { nil }
  end

  factory :comment, parent: :base_comment do
    comment { nil }
    post
  end
end
