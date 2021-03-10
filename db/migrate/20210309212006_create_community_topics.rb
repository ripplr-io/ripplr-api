class CreateCommunityTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :community_topics, id: :uuid do |t|
      t.belongs_to :community, type: :uuid
      t.belongs_to :topic, type: :uuid

      t.timestamps
    end
  end
end
