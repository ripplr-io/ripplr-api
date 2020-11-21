class BookmarkSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  # FIXME: Legacy attribute - remove
  attributes :bookmark_folder_id

  belongs_to :post
  belongs_to :bookmark_folder
end
