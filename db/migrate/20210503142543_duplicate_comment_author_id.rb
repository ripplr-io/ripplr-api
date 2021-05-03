class DuplicateCommentAuthorId < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :profile, type: :uuid

    Comment.all.each do |comment|
      comment.update(profile: comment.author.profile)
    end
  end
end
