require 'rails_helper'

RSpec.describe :inboxes_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch inbox_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      inbox = create(:inbox)
      patch inbox_path(inbox), headers: auth_headers_for_new_user
    end
  end

  it_behaves_like :unprocessable_request, [:name, :settings] do
    let(:subject) do
      inbox = create(:inbox)

      patch inbox_path(inbox),
        params: { name: nil, settings: nil },
        headers: auth_headers_for(inbox.user)
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    inbox = create(:inbox, user: user)

    patch inbox_path(inbox),
      params: inbox.as_json(only: [:name]).merge(settings: inbox.settings.to_json),
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(inbox)
  end
end
