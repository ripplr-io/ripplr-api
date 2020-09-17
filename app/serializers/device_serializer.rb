class DeviceSerializer < ActiveModel::Serializer
  attributes :id, :type, :name, :settings, :onesignal_id, :created_at, :updated_at

  def type
    object.device_type
  end

  def settings
    JSON.parse object.settings
  end
end
