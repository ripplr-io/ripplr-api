class BookmarkFolderSerializer < ActiveModel::Serializer
  attributes :id, :name, :bookmark_folder_id, :created_at, :stats, :bookmarks, :folders

  def bookmarks
    object.bookmarks.map do |bookmark|
      BookmarkSerializer.new(bookmark)
    end
  end

  def folders
    object.bookmark_folders.map do |folder|
      BookmarkFolderSerializer.new(folder)
    end
  end

  def stats
    {
      bookmarksCount: object.bookmarks.count,
      foldersCount: object.bookmark_folders.count
    }
  end
end
