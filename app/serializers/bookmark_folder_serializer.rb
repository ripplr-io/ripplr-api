class BookmarkFolderSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  has_many :bookmarks
  has_many :folders, serializer: :bookmark_folder, object_method_name: :bookmark_folders,
    id_method_name: :bookmark_folder_ids

  attributes :name, :created_at

  attribute :stats do |object|
    {
      bookmarksCount: object.bookmarks_count,
      foldersCount: object.bookmark_folders_count
    }
  end

  # FIXME: Legacy attributes - remove
  attribute :bookmark_folder_id
end
