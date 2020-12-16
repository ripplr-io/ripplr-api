class DeviceSerializer < ApplicationSerializer
  attributes :name, :settings, :onesignal_id, :created_at, :updated_at

  attribute :type, &:device_type
end
