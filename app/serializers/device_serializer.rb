class DeviceSerializer < ActiveModel::Serializer
  attributes :type, :name, :settings, :onesignal_id, :created_at, :updated_at

  def type
    object.device_type
  end
end
