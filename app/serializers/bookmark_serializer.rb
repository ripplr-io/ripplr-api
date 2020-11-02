class BookmarkSerializer < ActiveModel::Serializer
  attributes :bookmark_folder_id

  belongs_to :post
  belongs_to :bookmark_folder
end
