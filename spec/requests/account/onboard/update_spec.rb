require 'rails_helper'

RSpec.describe :account_onboard_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch account_onboard_path }
  end

  context 'status value is started' do
    it 'responds with the resource' do
      user = create(:user, onboarding_started_at: nil)

      put account_onboard_path,
        params: { status: :started },
        headers: auth_headers_for(user)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(user)
      expect(user.reload.onboarding_started_at).not_to eq nil
    end
  end

  context 'status value is finished' do
    it 'responds with the resource' do
      user = create(:user, onboarding_finished_at: nil)

      put account_onboard_path,
        params: { status: :finished },
        headers: auth_headers_for(user)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(user)
      expect(Prizes::Onboarding::CompletedBonusWorker.jobs.size).to eq(1)
    end
  end
end
