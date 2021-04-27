class DuplicateAuthorId < ActiveRecord::Migration[6.1]
  def change
    Post.all.each do |post|
      post.update(profile: post.author.profile)
    end
  end
end
