class SubscriptionSerializer < ActiveModel::Serializer
  attributes :subscribable_type, :subscribable_id, :settings, :created_at, :updated_at

  def subscribable_type
    object.subscribable_type.downcase
  end
end
