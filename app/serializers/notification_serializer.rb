class NotificationSerializer < ActiveModel::Serializer
  attributes :data, :read_at, :created_at, :author

  belongs_to :user

  def author
    return if object.data['author_id'].blank?

    User.find_by(id: object.data['author_id'])
  end
end
