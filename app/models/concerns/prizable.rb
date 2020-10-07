module Prizable
  extend ActiveSupport::Concern

  included do
    has_many :prizes, as: :prizable
  end
end
