class ApplicationSerializer
  include JSONAPI::Serializer

  class << self
    delegate :url_helpers, to: :'Rails.application.routes'
  end
end
