FactoryBot.define do
  factory :notification_new_rating, class: Notification::NewRating do
    ratable factory: :post
  end
end
