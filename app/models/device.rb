class Device < ApplicationRecord
  enum device_type: {
    computer: 'Computer',
    smartphone: 'Smartphone',
    tablet: 'Tablet'
  }

  belongs_to :user

  has_many :push_notifications, dependent: :destroy

  validates :device_type, presence: true
  validates :name, presence: true
  validates :onesignal_id, presence: true
  validates :settings, presence: true
end
