class BookmarkSerializer < ApplicationSerializer
  belongs_to :post
  belongs_to :bookmark_folder

  # FIXME: Legacy attributes - remove
  attributes :bookmark_folder_id
end
