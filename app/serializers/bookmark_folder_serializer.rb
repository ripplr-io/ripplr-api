class BookmarkFolderSerializer < ActiveModel::Serializer
  attributes :id, :name, :bookmark_folder_id, :created_at, :bookmarks, :folders, :stats

  def folders
    object.bookmark_folders
  end

  def stats
    {
      bookmarksCount: object.bookmarks.count,
      foldersCount: object.bookmark_folders.count
    }
  end
end
