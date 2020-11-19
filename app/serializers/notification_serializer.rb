class NotificationSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  attributes :data, :read_at, :created_at

  belongs_to :user

  belongs_to :author, serializer: :user do |object|
    next if object.data['author_id'].blank?

    User.find_by(id: object.data['author_id'])
  end

  # FIXME: Legacy author - remove
  attribute :author do |object|
    next if object.data['author_id'].blank?

    User.find_by(id: object.data['author_id']).as_json
  end
end
