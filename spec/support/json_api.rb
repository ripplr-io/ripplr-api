module JsonApiResponseHelpers
  def response_body
    @_response_body ||= JSON.parse(response.body, symbolize_names: true)
  end

  def response_data
    @_response_data ||= response_body.dig(:data)
  end

  def response_errors
    @_response_errors ||= response_body.dig(:errors)
  end
end

module JsonApiMatchers
  extend RSpec::Matchers::DSL

  # variable actual is meant to be document[:data]
  matcher :have_resource do |expected|
    match do |actual|
      return false if expected.nil? || actual.nil?

      actual = [actual] unless actual.is_a?(Array)

      ids = actual.map { |resource| resource[:id] }.compact
      ids.include? expected.id.to_s
    end
  end

  # variable actual is meant to be document[:errors]
  matcher :have_error do |expected|
    match do |actual|
      return false if actual.nil?

      attributes = actual.map { |resource| resource[:id] }.compact
      attributes.include? expected.to_s
    end
  end
end

RSpec.configure do |config|
  config.include JsonApiResponseHelpers, type: :request
  config.include JsonApiMatchers, type: :request
end
