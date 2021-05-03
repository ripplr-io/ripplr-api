class NotificationSerializer < ApplicationSerializer
  belongs_to :profile

  belongs_to :author, serializer: :profile do |object|
    author_id = object.data['author_id']
    next if author_id.blank?

    User.find_by(id: author_id)&.profile || Profile.find_by(id: author_id)
  end

  attributes :data, :read_at, :created_at
end
