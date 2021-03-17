class AddCommunityToContentSources < ActiveRecord::Migration[6.1]
  def change
    add_reference :content_sources, :community, type: :uuid
  end
end
