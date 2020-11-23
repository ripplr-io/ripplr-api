class ApplicationSerializer
  include JSONAPI::Serializer

  class << self
    delegate :url_helpers, to: :'Rails.application.routes'

    def record_cache_options(options, fieldset, include_list, params)
      opts = options.dup

      current_user = params[:current_user]
      opts[:namespace] += ":#{current_user.id}" if current_user.present?

      super(opts, fieldset, include_list, params)
    end
  end
end
