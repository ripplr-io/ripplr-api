require 'rails_helper'

RSpec.describe :explore_communities_index, type: :request do
  context 'user logged out' do
    it 'responds with all communities' do
      first_community = create(:community)
      second_community = create(:community)

      get explore_communities_path

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(first_community)
      expect(response_data).to have_resource(second_community)
    end
  end

  context 'user logged in' do
    it 'responds with communities the user doesn\'t follow' do
      user = create(:user)
      community = create(:community)
      followed_community = create(:follow, :for_community, user: user).followable

      get explore_communities_path, headers: auth_headers_for(user)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(community)
      expect(response_data).not_to have_resource(followed_community)
    end
  end
end
