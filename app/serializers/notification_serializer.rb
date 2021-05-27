class NotificationSerializer < ApplicationSerializer
  belongs_to :profile

  # TODO: Review performance of this hacks
  belongs_to :author, serializer: :profile do |object|
    author_id = object.notifiable.to_data[:author_id]
    next if author_id.blank?

    User.find_by(id: author_id)&.profile || Profile.find_by(id: author_id)
  end

  attributes :read_at, :created_at

  attribute :data do |object|
    object.notifiable.to_data
  end
end
