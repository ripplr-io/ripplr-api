class AddTotalsToModels < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :ratings_points_total, :integer, null: false, default: 0
    add_column :comments, :ratings_points_total, :integer, null: false, default: 0
    add_column :posts, :comments_count, :integer, null: false, default: 0
    add_column :comments, :replies_count, :integer, null: false, default: 0

    Comment.counter_culture_fix_counts
    Rating.counter_culture_fix_counts
  end
end
