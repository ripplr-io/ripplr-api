module Ratable
  extend ActiveSupport::Concern

  included do
    has_many :notification_new_ratings, as: :ratable, class_name: 'Notification::NewRating', dependent: :destroy
    has_many :ratings, as: :ratable, dependent: :destroy
  end
end
