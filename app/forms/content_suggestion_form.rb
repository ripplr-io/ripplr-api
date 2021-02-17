class ContentSuggestionForm
  include ActiveModel::Model

  attr_accessor :user, :topic, :name, :url

  validates :user, presence: true
  validates :topic, presence: true
  validates :name, presence: true
  validates :url, presence: true
end
