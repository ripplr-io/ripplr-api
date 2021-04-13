require 'rails_helper'

RSpec.describe :track_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post track_path }
  end

  context 'with the name param' do
    it 'tracks the event' do
      post track_path,
        params: { event_name: 'Event Name' },
        headers: auth_headers_for_new_user

      expect(response).to have_http_status(:no_content)
      expect(Segment::TrackAppEventWorker.jobs.size).to eq(1)
    end
  end

  context 'without the name param' do
    it 'tracks the event' do
      post track_path, headers: auth_headers_for_new_user

      expect(response).to have_http_status(:no_content)
      expect(Segment::TrackAppEventWorker.jobs.size).to eq(0)
    end
  end
end
