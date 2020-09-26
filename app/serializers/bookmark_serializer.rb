class BookmarkSerializer < ActiveModel::Serializer
  attributes :id, :bookmark_folder_id, :post
end
