class Comment < ApplicationRecord
  include Ratable

  belongs_to :author, class_name: :User
  belongs_to :post
  belongs_to :comment, optional: true

  has_many :comments, dependent: :destroy

  validates :body, presence: true

  before_validation :copy_parent_post

  acts_as_paranoid

  private

  def copy_parent_post
    self.post = comment.post if comment.present?
  end
end
