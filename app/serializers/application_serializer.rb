class ApplicationSerializer
  include JSONAPI::Serializer

  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  class << self
    delegate :url_helpers, to: :'Rails.application.routes'

    # NOTE: This includes the current_user id in the cache key, generating different
    # entries for each user, only if it passed as a param.
    def record_cache_options(options, fieldset, include_list, params)
      opts = options.dup

      current_user = params[:current_user]
      opts[:namespace] += ":#{current_user.id}" if current_user.present?

      super(opts, fieldset, include_list, params)
    end
  end
end
