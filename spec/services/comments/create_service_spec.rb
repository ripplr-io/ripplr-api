require 'rails_helper'

RSpec.describe Comments::CreateService, type: :service do
  it 'creates the comment' do
    comment = build(:comment)

    expect { described_class.new(comment).save }
      .to change { Comment.count }.by(1)

    expect(Comments::GenerateNotificationsWorker.jobs.size).to eq(1)
    expect(Mixpanel::TrackCommentCreatedWorker.jobs.size).to eq(1)
  end
end
