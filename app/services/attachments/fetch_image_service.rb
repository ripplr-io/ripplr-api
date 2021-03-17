require 'open-uri'

module Attachments
  class FetchImageService
    def initialize(url)
      @url = url
    end

    def call
      uri = URI.parse(@url)
      file = uri.open
      filename = File.basename(uri.path)

      { io: file, filename: filename }
    end
  end
end
