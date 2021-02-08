class InboxSerializer < ApplicationSerializer
  attributes :name, :settings, :description

  has_many :inbox_channels
end
