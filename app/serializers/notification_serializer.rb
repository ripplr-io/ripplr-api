class NotificationSerializer < ApplicationSerializer
  belongs_to :profile

  belongs_to :author, serializer: :profile do |object|
    next if object.data['author_id'].blank?

    User.find_by(id: object.data['author_id'])&.profile
  end

  attributes :data, :read_at, :created_at
end
