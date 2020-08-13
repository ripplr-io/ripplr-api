class User < ApplicationRecord
  extend FriendlyId

  has_many :comments, inverse_of: :author, foreign_key: :author_id
  has_many :posts, inverse_of: :author, foreign_key: :author_id
  has_many :ratings

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  friendly_id :name, use: :slugged

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
end
