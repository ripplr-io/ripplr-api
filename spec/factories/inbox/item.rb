FactoryBot.define do
  factory :inbox_item, class: Inbox::Item do
    for_post
    inbox

    trait :for_post do
      inboxable factory: :post
    end
  end
end
