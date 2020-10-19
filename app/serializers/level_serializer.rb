class LevelSerializer < ActiveModel::Serializer
  attributes :name, :from, :to, :posts, :referrals, :subscriptions
end
