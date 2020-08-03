class LevelSerializer < ActiveModel::Serializer
  attributes :id, :name, :from, :to, :posts, :referrals, :subscriptions
end
