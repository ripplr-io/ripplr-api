module Posts
  class UpdateTrendingScoreWorker < ApplicationWorker
    def perform(post_id)
      post = Post.find_by(id: post_id)
      return if post.blank?

      score = Posts::TrendingScoreService.new(post.ratings_points_total, post.created_at).calculate
      post.update(trending_score: score)
    end
  end
end
