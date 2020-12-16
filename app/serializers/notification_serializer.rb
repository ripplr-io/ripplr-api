class NotificationSerializer < ApplicationSerializer
  belongs_to :user

  belongs_to :author, serializer: :user do |object|
    next if object.data['author_id'].blank?

    User.find_by(id: object.data['author_id'])
  end

  attributes :data, :read_at, :created_at
end
