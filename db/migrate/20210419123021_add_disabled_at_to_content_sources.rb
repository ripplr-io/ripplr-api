class AddDisabledAtToContentSources < ActiveRecord::Migration[6.1]
  def change
    add_column :content_sources, :disabled_at, :datetime
  end
end
