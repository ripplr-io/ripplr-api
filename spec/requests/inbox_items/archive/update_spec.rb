require 'rails_helper'

RSpec.describe :inbox_items_archive_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { put inbox_item_archive_path(create(:inbox_item)) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      inbox_item = create(:inbox_item)
      put inbox_item_archive_path(inbox_item), headers: auth_headers_for_new_user
    end
  end

  context 'without params' do
    it 'sets archived_at to the current time' do
      inbox_item = create(:inbox_item, archived_at: nil)

      put inbox_item_archive_path(inbox_item), headers: auth_headers_for(inbox_item.inbox.user)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(inbox_item)
      expect(inbox_item.reload.archived_at).not_to eq(nil)
    end
  end

  context 'with status == true' do
    it 'sets archived_at to the current time' do
      inbox_item = create(:inbox_item, archived_at: nil)

      put inbox_item_archive_path(inbox_item),
        params: { status: true },
        headers: auth_headers_for(inbox_item.inbox.user)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(inbox_item)
      expect(inbox_item.reload.archived_at).not_to eq(nil)
    end
  end

  context 'with status == false' do
    it 'sets archived_at to nil' do
      inbox_item = create(:inbox_item, archived_at: Time.current)

      put inbox_item_archive_path(inbox_item),
        params: { status: false },
        headers: auth_headers_for(inbox_item.inbox.user)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(inbox_item)
      expect(inbox_item.reload.archived_at).to eq(nil)
    end
  end
end
