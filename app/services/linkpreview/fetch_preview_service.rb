module Linkpreview
  class FetchPreviewService
    include Rails.application.routes.url_helpers

    def initialize(url)
      @url = url
      @proxy_url = linkpreview_url(@url)
    end

    def call
      response = HTTParty.get(@proxy_url)
      return error_data unless response.ok?

      success_data(response.body)
    end

    private

    def success_data(body)
      data = JSON.parse(body, symbolize_names: true)

      {
        title: data[:title],
        body: data[:description],
        image: data[:image],
        url: data[:url]
      }
    end

    def error_data
      {
        url: @url
      }
    end
  end
end
