class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :subscribable, polymorphic: true

  has_many :push_notifications, dependent: :destroy

  validates :settings, presence: true

  def devices
    device_settings = settings['devices']
    user_devices = user.devices

    case device_settings['value']
    when 'all'
      user_devices
    when 'only'
      user_devices.where(id: device_settings['only'])
    when 'except'
      user_devices.where.not(id: device_settings['except'])
    else
      user_devices
    end
  end
end
