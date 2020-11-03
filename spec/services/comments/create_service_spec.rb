require 'rails_helper'

RSpec.describe Comments::CreateService, type: :service do
  it 'creates the comment' do
    comment_params = {
      body: 'Body',
      post: create(:post),
      author: create(:user)
    }

    expect { described_class.new(comment_params).save }
      .to change { Comment.count }.by(1)

    expect(Comments::GenerateNotificationsWorker.jobs.size).to eq(1)
  end
end
