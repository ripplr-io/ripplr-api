require 'rails_helper'

RSpec.describe :tickets_create, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      post tickets_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
      user = create(:user)
      sign_in user
      mock_ticket = build(:ticket)

      post tickets_path, as: :json, params: mock_ticket.as_json(only: [:title, :body]).merge!(
        screenshots: {}
      )

      expect(response).to have_http_status(:created)
      expect(response_data).to have_resource(Ticket.last)
    end

    it 'responds with errors' do
      user = create(:user)
      sign_in user

      post tickets_path

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:title)
      expect(response_errors).to have_error(:body)
    end
  end
end
