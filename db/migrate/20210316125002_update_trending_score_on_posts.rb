class UpdateTrendingScoreOnPosts < ActiveRecord::Migration[6.1]
  def up
    Post.all.each do |p|
      Posts::UpdateTrendingScoreWorker.perform_async(p.id)
    end
  end
end
