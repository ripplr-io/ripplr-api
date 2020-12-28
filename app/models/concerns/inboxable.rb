module Inboxable
  extend ActiveSupport::Concern

  included do
    has_many :inbox_items, as: :inboxable, class_name: 'Inbox::Item', dependent: :destroy
    has_many :inboxes, through: :inbox_items
  end
end
