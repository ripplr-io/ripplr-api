require 'rails_helper'

RSpec.describe Notifications::NewRatingWorker, type: :worker do
  subject { described_class.new.perform(rating.id) }

  context 'notification does not exist' do
    let!(:rating) { create(:rating) }

    it 'creates a notification' do
      expect { subject }
        .to change { Notification.count }.by(1)
        .and change { Notification::NewRating.count }.by(1)

      expect(Notification.last.last_activity_at).not_to eq(nil)
      expect(Notification.last.read_at).to eq(nil)
    end
  end

  context 'notification exists' do
    let(:notification) { create(:notification, :for_new_rating) }
    let!(:rating) { create(:rating, ratable: notification.notifiable.ratable) }

    it 'updates the notification' do
      expect { subject }
        .to change { Notification.count }.by(0)
        .and change { Notification::NewRating.count }.by(0)

      original_timestamp = notification.last_activity_at
      expect(notification.reload.last_activity_at).not_to eq(original_timestamp)
      expect(notification.reload.read_at).to eq(nil)
    end
  end
end
