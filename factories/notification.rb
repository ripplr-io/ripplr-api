FactoryBot.define do
  factory :notification do
    user
    notification_type { Notification.notification_types.values.sample }
    read_at { nil }
    data { '{}' }
  end
end
