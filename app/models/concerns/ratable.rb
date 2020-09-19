module Ratable
  extend ActiveSupport::Concern

  included do
    has_many :ratings, as: :ratable
  end
end
