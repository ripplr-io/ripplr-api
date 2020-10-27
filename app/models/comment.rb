class Comment < ApplicationRecord
  include Ratable

  belongs_to :author, class_name: :User
  belongs_to :post
  belongs_to :comment, optional: true

  has_many :comments

  validates :body, presence: true

  before_validation :copy_parent_post

  after_commit :generate_create_notification, on: :create

  private

  def copy_parent_post
    self.post = comment.post if comment.present?
  end

  def generate_create_notification
    Notifications::NewComment.create(user: post.author, comment: self) unless author == post.author

    return if comment.nil? || author == comment.author || comment.author == post.author

    Notifications::NewReply.create(user: comment.author, comment: self)
  end
end
