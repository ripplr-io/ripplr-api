FactoryBot.define do
  factory :rating, aliases: [:post_rating] do
    user
    ratable factory: :post

    points { [1, 2, 3, 5, 8].sample }
  end

  factory :comment_rating, parent: :rating do
    ratable factory: :comment
  end

  factory :reply_rating, parent: :rating do
    ratable factory: :reply
  end
end
