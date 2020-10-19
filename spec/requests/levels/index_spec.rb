require 'rails_helper'

RSpec.describe :levels_index, type: :request do
  it 'responds with the resources' do
    level_a = create(:level)
    level_b = create(:level)

    get levels_path

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(level_a)
    expect(response_data).to have_resource(level_b)
  end
end
