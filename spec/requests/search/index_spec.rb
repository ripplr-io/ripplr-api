require 'rails_helper'

RSpec.describe :search_index, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      get search_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with data' do
      user = create(:user)

      get search_path, headers: auth_headers_for(user)

      expect(response).to have_http_status(:ok)
      expect(response_data[:topics]).to be_empty
      expect(response_data[:users]).to be_empty
      expect(response_data[:hashtags]).to be_empty
      expect(response_data[:posts]).to be_empty
    end

    it 'serializes the resource' do
      user = create(:user)
      topic = create(:topic, name: 'Business')

      get search_path(query: 'Busi', vertical: 'everything'), headers: auth_headers_for(user)

      expect(response).to have_http_status(:ok)
      expect(response_data[:topics]).not_to be_empty
      expect(response_data[:topics].first[:data]).to have_resource(topic)
    end

    it 'instantiates a search service' do
      user = create(:user)

      expect(Search::SearchService).to receive(:new).with('query', '1', '10').and_call_original

      get search_path(query: 'query', page: '1', per_page: '10'), headers: auth_headers_for(user)
    end

    it 'sets the search filters' do
      user = create(:user)

      expect_any_instance_of(Search::SearchService).to receive(:add_posts_filter).twice.and_call_original

      get search_path(user: 'following', topic: 'following'), headers: auth_headers_for(user)
    end

    it 'gets the grouped_results' do
      user = create(:user)

      expect_any_instance_of(Search::SearchService).to receive(:grouped_results).and_call_original

      get search_path(vertical: 'everything'), headers: auth_headers_for(user)
    end

    it 'gets the individual_results' do
      user = create(:user)

      expect_any_instance_of(Search::SearchService).to receive(:individual_results).and_call_original

      get search_path(vertical: 'posts'), headers: auth_headers_for(user)
    end
  end
end
