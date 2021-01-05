FactoryBot.define do
  factory :inbox_item do
    for_post
    inbox

    trait :for_post do
      inboxable factory: :post
    end
  end
end
