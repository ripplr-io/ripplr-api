module Feedjira
  class FetchUrlsService
    def initialize(feed_url)
      xml = HTTParty.get(feed_url).body
      @feed = Feedjira.parse(xml)
    end

    def data
      @feed.entries.map do |entry|
        {
          url: entry[:url],
          title: entry[:title],
          body: (entry[:summary] || html_to_text(entry[:content])),
          image: entry[:image] || entry[:media_thumbnail_url]
        }
      end
    end

    private

    def html_to_text(html)
      Nokogiri::HTML(html).text
    end
  end
end
