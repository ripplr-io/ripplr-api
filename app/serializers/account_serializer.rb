class AccountSerializer < UserSerializer
  set_type :user

  belongs_to :level

  attribute :onboarded_at, :subscribed_to_marketing, :onboarding_started_at, :onboarding_finished_at

  attribute :accountInfo do |object|
    {
      email: object.email,
      country: object.country,
      timezone: object.timezone
    }
  end

  attribute :onboarding_prizes do |object|
    names = Prize::ONBOARDING_PRIZES.values.pluck(:name)
    account_prizes = object.prizes.where(name: names).pluck(:name)

    data = {}
    Prize::ONBOARDING_PRIZES.each do |key, value|
      data[key] = account_prizes.include? value[:name]
    end

    data
  end
end
