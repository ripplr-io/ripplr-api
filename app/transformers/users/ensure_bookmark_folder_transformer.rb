module Users
  class EnsureBookmarkFolderTransformer
    def transform(record)
      return if record.bookmark_folders.any?

      record.bookmark_folders.build(name: 'Root')
    end
  end
end
