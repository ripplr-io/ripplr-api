require 'rails_helper'

RSpec.describe :ratings_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) do
      ratable = create(:post)
      post post_ratings_path(ratable)
    end
  end

  it_behaves_like :unprocessable_request, [:points] do
    let(:subject) do
      ratable = create(:post)
      post post_ratings_path(ratable), headers: auth_headers_for_new_user
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    ratable = create(:post)

    post post_ratings_path(ratable),
      params: { rate: 3 },
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(Rating.last)
  end
end
