class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if url_valid?(value)

    record.errors.add(attribute, 'is not a valid url')
  end

  private

  def url_valid?(url)
    uri = URI.parse(url)
    valid_schema = uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
    valid_host = uri.host.present?

    valid_schema && valid_host
  rescue URI::InvalidURIError
    false
  end
end
