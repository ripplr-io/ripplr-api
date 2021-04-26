require 'rails_helper'

RSpec.describe :search_index, type: :request do
  it 'responds with data' do
    get search_path

    expect(response).to have_http_status(:ok)
    expect(response_data[:topics]).to be_empty
    expect(response_data[:users]).to be_empty
    expect(response_data[:hashtags]).to be_empty
    expect(response_data[:communities]).to be_empty
    expect(response_data[:posts]).to be_empty
  end

  it 'serializes the resource' do
    topic = create(:topic, name: 'Business')

    get search_path(query: 'Busi', vertical: 'everything')

    expect(response).to have_http_status(:ok)
    expect(response_data[:topics]).not_to be_empty
    expect(response_data[:topics].first[:data]).to have_resource(topic)
  end

  it 'instantiates a search service' do
    expect(Search::SearchService).to receive(:new).with('query', '1', '10').and_call_original

    get search_path(query: 'query', page: '1', per_page: '10')
  end

  it 'gets the grouped_results' do
    expect_any_instance_of(Search::SearchService).to receive(:grouped_results).and_call_original

    get search_path(vertical: 'everything')
  end

  it 'gets the individual_results' do
    expect_any_instance_of(Search::SearchService).to receive(:individual_results).and_call_original

    get search_path(vertical: 'posts')
  end

  context 'user authenticated' do
    it 'sets the search filters' do
      expect_any_instance_of(Search::SearchService).to receive(:add_posts_filter).twice.and_call_original

      get search_path(user: 'following', topic: 'following'), headers: auth_headers_for_new_user
    end
  end

  context 'user not authenticated' do
    it 'sets the search filters' do
      expect_any_instance_of(Search::SearchService).not_to receive(:add_posts_filter).and_call_original

      get search_path(user: 'following', topic: 'following')
    end
  end
end
