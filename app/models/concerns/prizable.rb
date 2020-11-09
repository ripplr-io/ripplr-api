module Prizable
  extend ActiveSupport::Concern

  included do
    has_many :prizes, as: :prizable, dependent: :destroy
  end
end
