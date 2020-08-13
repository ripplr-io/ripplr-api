class Comment < ApplicationRecord
  belongs_to :author, class_name: :User
  belongs_to :post
  belongs_to :parent, class_name: :Comment, optional: true

  has_many :comments, inverse_of: :parent, foreign_key: :parent_id

  before_save :copy_parent_post, if: :parent_id?

  private

  def copy_parent_post
    post = parent.post
  end
end
