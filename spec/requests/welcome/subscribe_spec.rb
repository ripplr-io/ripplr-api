require 'rails_helper'

RSpec.describe :welcome_subscribe, type: :request do
  it 'responds with ok' do
    post subscribe_path

    expect(response).to have_http_status(:ok)
    expect(Sendgrid::CreateLeadWorker.jobs.size).to eq(1)
  end
end
