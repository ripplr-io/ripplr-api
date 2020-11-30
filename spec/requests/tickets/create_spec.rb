require 'rails_helper'

RSpec.describe :tickets_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post tickets_path }
  end

  it_behaves_like :unprocessable_request, [:title, :body] do
    let(:subject) { post tickets_path, headers: auth_headers_for_new_user }
  end

  it 'responds with the resource' do
    user = create(:user)
    mock_ticket = build(:ticket)

    post tickets_path, params: mock_ticket.as_json(only: [:title, :body]).merge(
      screenshots: {}
    ), headers: auth_headers_for(user)

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(Ticket.last)
  end
end
