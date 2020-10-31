require 'rails_helper'

RSpec.describe Search::SearchService, type: :service do
  it 'initializes' do
    service = described_class.new('que', 1, 10)

    expect(service.instance_variable_get(:@query)).to eq('que')
    expect(service.instance_variable_get(:@page)).to eq(1)
    expect(service.instance_variable_get(:@per_page)).to eq(10)
    expect(service.instance_variable_get(:@post_filters)).to be_empty
  end

  it 'can receive post filters' do
    service = described_class.new('que', 1, 10)
    service.add_posts_filter([1, 2, 3])

    expect(service.instance_variable_get(:@post_filters)).to eq([[1, 2, 3]])
  end

  describe '#grouped_results' do
    it 'returns empty arrays by default' do
      results = described_class.new('que', 1, 10).grouped_results

      expect(results[:topics]).to be_empty
      expect(results[:users]).to be_empty
      expect(results[:hashtags]).to be_empty
      expect(results[:posts]).to be_empty
    end

    it 'limits the results to 4 except on posts' do
      5.times do |index|
        create(:user, name: "query#{index}")
        create(:topic, name: "query#{index}")
        create(:hashtag, name: "query#{index}")
        create(:post, title: "query#{index}")
      end

      results = described_class.new('que', 1, 10).grouped_results

      expect(results[:topics].size).to be(4)
      expect(results[:users].size).to be(4)
      expect(results[:hashtags].size).to be(4)
      expect(results[:posts].size).to be(5)
    end

    it 'paginates posts' do
      3.times do |index|
        create(:post, title: "query#{index}")
      end

      first_page_results = described_class.new('que', 1, 2).grouped_results
      second_page_results = described_class.new('que', 2, 2).grouped_results
      third_page_results = described_class.new('que', 3, 2).grouped_results

      expect(first_page_results[:posts].size).to be(2)
      expect(second_page_results[:posts].size).to be(1)
      expect(third_page_results[:posts].size).to be(0)
    end
  end

  describe '#individual_results' do
    it 'returns individual results' do
      create(:user, name: 'query')
      create(:topic, name: 'query')
      create(:hashtag, name: 'query')
      create(:post, title: 'query')

      service = described_class.new('que', 1, 10)

      other_results = service.individual_results('other')
      topic_results = service.individual_results('topics')
      user_results = service.individual_results('users')
      hashtag_results = service.individual_results('hashtags')
      post_results = service.individual_results('posts')

      expect(other_results[:topics]).to be_empty
      expect(other_results[:users]).to be_empty
      expect(other_results[:hashtags]).to be_empty
      expect(other_results[:posts]).to be_empty

      expect(topic_results[:topics]).not_to be_empty
      expect(user_results[:users]).not_to be_empty
      expect(hashtag_results[:hashtags]).not_to be_empty
      expect(post_results[:posts]).not_to be_empty
    end

    it 'returns paginated results' do
      2.times do |index|
        create(:user, name: "query#{index}")
        create(:topic, name: "query#{index}")
        create(:hashtag, name: "query#{index}")
        create(:post, title: "query#{index}")
      end

      service = described_class.new('que', 1, 1)

      topic_results = service.individual_results('topics')
      user_results = service.individual_results('users')
      hashtag_results = service.individual_results('hashtags')
      post_results = service.individual_results('posts')

      expect(topic_results[:topics].size).to eq(1)
      expect(user_results[:users].size).to eq(1)
      expect(hashtag_results[:hashtags].size).to eq(1)
      expect(post_results[:posts].size).to eq(1)
    end
  end

  describe 'filtering out posts' do
    it 'limits the results to the values of a filter' do
      5.times do |index|
        create(:post, title: "query#{index}")
      end

      filter = Post.first(3).pluck(:id)

      default_service = described_class.new('que', 1, 10)
      filtered_service = described_class.new('que', 1, 10)
      filtered_service.add_posts_filter(filter)

      expect(default_service.send(:post_results).size).to eq(5)
      expect(filtered_service.send(:post_results).size).to eq(3)
    end

    it 'limits the results to the combined values of the filters' do
      5.times do |index|
        create(:post, title: "query#{index}")
      end

      filter_a = Post.first(3).pluck(:id)
      filter_b = Post.last(3).pluck(:id)

      service = described_class.new('que', 1, 10)
      service.add_posts_filter(filter_a)
      service.add_posts_filter(filter_b)

      expect(service.send(:post_results).size).to eq(1)
    end
  end
end
