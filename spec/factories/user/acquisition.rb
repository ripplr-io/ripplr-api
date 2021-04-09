FactoryBot.define do
  factory :user_acquisition, class: User::Acquisition do
    user
    medium { Faker::Lorem.word }
    source { Faker::Lorem.word }
    campaign { Faker::Lorem.word }
  end
end
