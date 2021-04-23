module Profilable
  extend ActiveSupport::Concern

  TYPES = ['User'].freeze

  included do
    has_one :profile, as: :profilable, touch: true, dependent: :destroy
  end
end
