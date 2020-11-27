require 'rails_helper'

RSpec.describe :reports_create, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with not_found' do
      post post_reports_path(0)
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
      user = create(:user)
      mock_post = create(:post)

      post post_reports_path(mock_post), params: { reason: 'reason', body: 'body' }, headers: auth_headers_for(user)

      expect(response).to have_http_status(:no_content)
      # FIXME: Add this expectation
      # expect(Sidekiq::Queues['mailers'].size).to eq 1
    end

    it 'responds with errors' do
      user = create(:user)

      post post_reports_path(0), headers: auth_headers_for(user)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:reason)
      expect(response_errors).to have_error(:body)
    end
  end
end
