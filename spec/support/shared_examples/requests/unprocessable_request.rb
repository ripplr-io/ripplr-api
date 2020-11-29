require 'spec_helper'

shared_examples_for :unprocessable_request do |errors = []|
  context 'when the request failed' do
    it 'responds with unprocessable_entity' do
      subject

      expect(response).to have_http_status(:unprocessable_entity)
      errors.each do |error|
        expect(response_errors).to have_error(error)
      end
    end
  end
end
