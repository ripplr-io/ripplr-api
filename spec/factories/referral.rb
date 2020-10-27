FactoryBot.define do
  factory :referral do
    inviter factory: :user
    invitee { nil }

    name { Faker::Name.name }
    email { Faker::Internet.email }
    accepted_at { nil }
  end
end
