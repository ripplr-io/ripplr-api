class NotificationSerializer < ActiveModel::Serializer
  attributes :data, :read_at, :created_at, :author

  belongs_to :user

  def author
    return if object.data['user_id'].blank?

    User.find_by(id: object.data['user_id'])
  end
end
