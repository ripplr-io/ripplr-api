require 'rails_helper'

RSpec.describe :inbox_items_index, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { get inbox_inbox_items_path(create(:inbox_item).inbox) }
  end

  it 'responds with the inbox items resources' do
    inbox_item = create(:inbox_item)
    other_inbox_item = create(:inbox_item)

    get inbox_inbox_items_path(inbox_item.inbox), headers: auth_headers_for(inbox_item.inbox.user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(inbox_item)
    expect(response_data).not_to have_resource(other_inbox_item)
    expect(response_included).to have_resource(inbox_item.inboxable)
  end

  context 'filter' do
    context 'default' do
      it 'shows items not archived' do
        inbox = create(:inbox)
        item_not_archived = create(:inbox_item, inbox: inbox, archived_at: nil)
        item_archived = create(:inbox_item, inbox: inbox, archived_at: Time.current)

        get inbox_inbox_items_path(inbox), headers: auth_headers_for(inbox.user)

        expect(response).to have_http_status(:ok)
        expect(response_data).to have_resource(item_not_archived)
        expect(response_data).not_to have_resource(item_archived)
      end
    end

    context 'with include_archived' do
      it 'shows all results' do
        inbox = create(:inbox)
        item_not_archived = create(:inbox_item, inbox: inbox, archived_at: nil)
        item_archived = create(:inbox_item, inbox: inbox, archived_at: Time.current)

        get inbox_inbox_items_path(inbox),
          params: { include_archived: true },
          headers: auth_headers_for(inbox.user)

        expect(response).to have_http_status(:ok)
        expect(response_data).to have_resource(item_not_archived)
        expect(response_data).to have_resource(item_archived)
      end
    end

    context 'with include_archived eq false' do
      it 'shows items not archived' do
        inbox = create(:inbox)
        item_not_archived = create(:inbox_item, inbox: inbox, archived_at: nil)
        item_archived = create(:inbox_item, inbox: inbox, archived_at: Time.current)

        get inbox_inbox_items_path(inbox),
          params: { include_archived: false },
          headers: auth_headers_for(inbox.user)

        expect(response).to have_http_status(:ok)
        expect(response_data).to have_resource(item_not_archived)
        expect(response_data).not_to have_resource(item_archived)
      end
    end
  end
end
