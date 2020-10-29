require 'rails_helper'

RSpec.describe :welcome_status, type: :request do
  it 'responds with ok' do
    get root_path

    expect(response).to have_http_status(:ok)
  end
end
