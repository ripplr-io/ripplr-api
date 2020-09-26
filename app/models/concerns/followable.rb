module Followable
  extend ActiveSupport::Concern

  included do
    has_many :received_follows, as: :followable, class_name: :Follow
    has_many :followers, through: :received_follows, source: :user
  end
end