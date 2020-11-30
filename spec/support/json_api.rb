module JsonApiResponseHelpers
  def response_body
    @_response_body ||= JSON.parse(response.body, symbolize_names: true)
  end

  def response_data
    @_response_data ||= response_body[:data]
  end

  def response_errors
    @_response_errors ||= response_body[:errors]
  end

  def response_included
    @_response_included ||= response_body[:included]
  end
end

module JsonApiMatchers
  extend RSpec::Matchers::DSL

  # NOTE: variable actual is meant to be document[:data] or document[:include]
  matcher :have_resource do |expected|
    match do |actual|
      return false if expected.nil? || actual.nil?

      actual = [actual] unless actual.is_a?(Array)

      ids = actual.pluck(:id).compact
      ids.include? expected.id
    end
  end

  # NOTE: variable actual is meant to be document[:errors]
  matcher :have_error do |expected|
    match do |actual|
      return false if actual.nil?

      attributes = actual.pluck(:id).compact
      attributes.include? expected.to_s
    end
  end
end

RSpec.configure do |config|
  config.include JsonApiResponseHelpers, type: :request
  config.include JsonApiMatchers, type: :request
end
