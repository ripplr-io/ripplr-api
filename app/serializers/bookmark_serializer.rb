class BookmarkSerializer < ActiveModel::Serializer
  belongs_to :post
  belongs_to :bookmark_folder
end
