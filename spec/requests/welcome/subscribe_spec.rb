require 'rails_helper'

RSpec.describe :welcome_subscribe, type: :request do
  context 'invalid email' do
    it_behaves_like :unprocessable_request, [:email] do
      let(:subject) { post subscribe_path, params: { email: 'name' } }
    end
  end

  context 'valid email' do
    it 'responds with no_content' do
      post subscribe_path, params: { email: 'email@ripplr.io' }

      expect(response).to have_http_status(:no_content)
      expect(Sendgrid::CreateLeadWorker.jobs.size).to eq(1)
    end
  end
end
