class LinkPreview
  class << self
    include Rails.application.routes.url_helpers

    def fetch(url)
      url ||= ''

      response = HTTParty.get(linkpreview_url(url))
      return { url: url } unless response.ok?

      format_data(response.body)
    end

    private

    def format_data(body)
      data = JSON.parse(body, symbolize_names: true)

      {
        title: data[:title],
        body: data[:description],
        image: data[:image],
        url: data[:url]
      }
    end
  end
end
