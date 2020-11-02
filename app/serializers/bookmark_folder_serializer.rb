class BookmarkFolderSerializer < ActiveModel::Serializer
  attributes :name, :bookmark_folder_id, :created_at, :stats

  has_many :bookmarks
  has_many :bookmark_folders, key: :folders

  def stats
    {
      bookmarksCount: object.bookmarks.count,
      foldersCount: object.bookmark_folders.count
    }
  end
end
