class DeviceSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  attributes :name, :settings, :onesignal_id, :created_at, :updated_at

  attribute :type do |object|
    object.device_type
  end
end
