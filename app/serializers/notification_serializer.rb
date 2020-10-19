class NotificationSerializer < ActiveModel::Serializer
  attributes :type, :data, :read_at, :created_at

  belongs_to :user

  def type
    object.notification_type
  end
end
