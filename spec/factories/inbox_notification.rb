FactoryBot.define do
  factory :inbox_notification do
    # TODO: Make sure inbox_channel and inbox_item belong to the same inbox?
    inbox_channel
    inbox_item
  end
end
