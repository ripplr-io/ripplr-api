require 'rails_helper'

RSpec.describe Comments::Create, type: :interactor do
  it 'creates the comment' do
    comment = build(:comment)

    expect { described_class.call(resource: comment) }
      .to change { Comment.count }.by(1)

    expect(Comments::GenerateNotificationsWorker.jobs.size).to eq(1)
    expect(Segment::TrackCommentCreatedWorker.jobs.size).to eq(1)
  end
end
