module Feedjira
  class FetchUrlsService
    def initialize(feed_url)
      xml = HTTParty.get(feed_url).body
      @feed = Feedjira.parse(xml)
    end

    def urls
      @feed.entries.map(&:url)
    end
  end
end
