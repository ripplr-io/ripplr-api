require 'rails_helper'

RSpec.describe Posts::TrendingScoreService, type: :service do
  let!(:current_time) { Time.current }

  context 'rating eq to 0' do
    subject(:original_post_score) { described_class.new(0, current_time).calculate }

    it 'is overtaken by newer ratings of 0' do
      new_post_score = described_class.new(0, current_time + 1.second).calculate
      is_expected.to be < new_post_score
    end
  end

  context 'rating eq to 10' do
    subject(:original_post_score) { described_class.new(10, current_time).calculate }

    it 'is overtaken by a rating of 0 after 1 week' do
      new_post_score = described_class.new(0, current_time + 1.1.weeks).calculate
      is_expected.to be < new_post_score
    end
  end

  context 'rating eq to 100' do
    subject(:original_post_score) { described_class.new(100, current_time).calculate }

    it 'is overtaken by a rating of 10 after 1 week' do
      new_post_score = described_class.new(10, current_time + 1.1.weeks).calculate
      is_expected.to be < new_post_score
    end

    it 'is overtaken by a rating of 0 in 2 weeks' do
      new_post_score = described_class.new(0, current_time + 2.1.weeks).calculate
      is_expected.to be < new_post_score
    end
  end

  context 'rating eq to 1000' do
    subject(:original_post_score) { described_class.new(1000, current_time).calculate }

    it 'is overtaken by a rating of 100 after 1 week' do
      new_post_score = described_class.new(100, current_time + 1.1.weeks).calculate
      is_expected.to be < new_post_score
    end

    it 'is overtaken by a rating of 10 after 2 weeks' do
      new_post_score = described_class.new(10, current_time + 2.1.weeks).calculate
      is_expected.to be < new_post_score
    end

    it 'is overtaken by a rating of 0 after 3 weeks' do
      new_post_score = described_class.new(0, current_time + 3.1.weeks).calculate
      is_expected.to be < new_post_score
    end
  end
end
