class BookmarkSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  belongs_to :post
  belongs_to :bookmark_folder

  # FIXME: Legacy attributes - remove
  attributes :bookmark_folder_id
end
