class AddTrendingScoreToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :trending_score, :integer, null: false, default: 0
    add_index :posts, :trending_score
  end
end
