class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :type, :data, :user, :read_at, :created_at

  def type
    object.notification_type
  end
end
