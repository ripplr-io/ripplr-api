require 'rails_helper'

RSpec.describe Posts::UpdateTrendingScoreWorker, type: :worker do
  it 'broadcasts to the channels' do
    post = create(:post, trending_score: 0)

    described_class.new.perform(post.id)

    expect(post.reload.trending_score).not_to eq(0)
  end
end
