module Subscribable
  extend ActiveSupport::Concern

  included do
    has_many :received_subscriptions, as: :subscribable, class_name: :Subscription, dependent: :destroy
    has_many :subscribers, through: :received_subscriptions, source: :user
  end
end
