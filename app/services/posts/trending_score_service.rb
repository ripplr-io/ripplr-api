module Posts
  class TrendingScoreService
    def initialize(rating, created_at)
      @rating = rating
      @created_at = created_at
    end

    def calculate
      (rating_score + time_score).to_i
    end

    private

    # NOTE: time_score is equal to the number of seconds since 1/1/1970.
    # Newer posts will always have a higher time_score. These values are usually
    # around 1.6M (as of 2021).
    def time_score
      @created_at.to_i
    end

    # NOTE: rating_scores converts the log_rating into a number in seconds
    # This total will be added to the overral score. To simplify, it can be read
    # as 'total time before this post is overtaken by a new post with 0 points'.
    def rating_score
      logarithmic_rating * 1.week.to_i
    end

    # NOTE: logarithmic_rating makes each point weight less as the total increases.
    # This ensures that only the few outstanding posts will remain popular as
    # the weeks pass.
    # NOTE: 0 and 1 ratings will have the same score
    def logarithmic_rating
      return 0 if @rating.zero?

      Math.log(@rating, 10)
    end
  end
end
