module Search
  class SearchService
    def initialize(query, page, per_page)
      @query = query
      @page = page
      @per_page = per_page
      @post_filters = []
    end

    def add_posts_filter(filter)
      @post_filters << filter
    end

    def grouped_results
      {
        topics: topic_results.first(4),
        users: user_results.first(4),
        hashtags: hashtag_results.first(4),
        communities: community_results.first(4),
        posts: post_results.page(@page).per(@per_page)
      }
    end

    def individual_results(record_type)
      results = {}
      results[:topics] = record_type == 'topics' ? topic_results.page(@page).per(@per_page) : []
      results[:users] = record_type == 'users' ? user_results.page(@page).per(@per_page) : []
      results[:hashtags] = record_type == 'hashtags' ? hashtag_results.page(@page).per(@per_page) : []
      results[:communities] = record_type == 'communities' ? community_results.page(@page).per(@per_page) : []
      results[:posts] = record_type == 'posts' ? post_results.page(@page).per(@per_page) : []
      results
    end

    private

    def topic_results
      Topic.search(@query)
    end

    def hashtag_results
      Hashtag.search(@query)
    end

    def community_results
      Community.search(@query)
    end

    def user_results
      User.search(@query)
    end

    def post_results
      posts = Post.search(@query).includes(:author, :hashtags, :topic, :communities)

      @post_filters.each do |filter|
        posts = posts.where(id: filter)
      end

      posts
    end
  end
end
