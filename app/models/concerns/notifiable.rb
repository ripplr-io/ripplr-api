module Notifiable
  extend ActiveSupport::Concern

  TYPES = [
    'Notification::AcceptedReferral',
    'Notification::NewComment',
    'Notification::NewFollower',
    'Notification::NewLevel',
    'Notification::NewReply'
  ].freeze

  included do
    has_one :notification, as: :notifiable, touch: true, dependent: :destroy
  end
end
