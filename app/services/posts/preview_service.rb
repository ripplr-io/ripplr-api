module Posts
  class PreviewService
    def initialize(url)
      @url = url || ''
    end

    def data
      page = MetaInspector.new(@url)
      raise MetaInspector::RequestError unless page.response.status == 200

      success_data(page)
    rescue MetaInspector::TimeoutError, MetaInspector::RequestError, MetaInspector::ParserError
      error_data
    end

    private

    def success_data(page)
      {
        title: page.best_title,
        body: page.best_description,
        image: page.images.best,
        url: page.url
      }
    end

    def error_data
      {
        url: @url
      }
    end
  end
end
