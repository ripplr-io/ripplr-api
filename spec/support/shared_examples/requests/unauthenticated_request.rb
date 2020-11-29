require 'spec_helper'

shared_examples_for :unauthenticated_request do
  context 'when the user is not authenticated' do
    it 'responds with not_found' do
      subject

      expect(response).to have_http_status(:not_found)
    end
  end
end
