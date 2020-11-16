class RemoveImageFromPosts < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :image, :legacy_image

    Post.all.each do |post|
      uri = URI.parse(post.legacy_image)
      file = uri.open
      filename = File.basename(uri.path)
      post.image.attach(io: file, filename: filename)
    end

    remove_column :posts, :legacy_image, :string
  end
end
