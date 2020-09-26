class Ticket < ApplicationRecord
  belongs_to :user

  has_many_attached :screenshots

  validates :title, presence: true
  validates :body, presence: true
end
