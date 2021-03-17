class RemoveTopicFromContentSources < ActiveRecord::Migration[6.1]
  def change
    remove_reference :content_sources, :topic
  end
end
