require 'spec_helper'

shared_examples_for :forbidden_request do
  context 'when the user does not have access to the resource' do
    it 'responds with not_found' do
      subject

      expect(response).to have_http_status(:not_found)
    end
  end
end
