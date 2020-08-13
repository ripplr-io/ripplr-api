class Comment < ApplicationRecord
  belongs_to :author, class_name: :User
  belongs_to :post
  belongs_to :comment, optional: true

  has_many :comments

  before_save :copy_parent_post, if: :comment_id?

  private

  def copy_parent_post
    post = comment.post
  end
end
