require 'rails_helper'

RSpec.describe Segment::TrackFollowCreatedWorker, type: :worker do
  context 'Followable is a user' do
    it 'calls the service' do
      follow = create(:follow, followable: create(:user))

      expect_any_instance_of(Segment::TrackService).to receive(:call).with(
        follow.user,
        'Follow Created',
        { 'Followable type' => 'User' }
      )

      described_class.new.perform(follow.id)
    end
  end

  context 'Followable is a topic' do
    it 'calls the service' do
      follow = create(:follow, followable: create(:topic))

      expect_any_instance_of(Segment::TrackService).to receive(:call).with(
        follow.user,
        'Follow Created',
        { 'Followable type' => 'Topic' }
      )

      described_class.new.perform(follow.id)
    end
  end

  context 'Followable is a hashtag' do
    it 'calls the service' do
      follow = create(:follow, followable: create(:hashtag))

      expect_any_instance_of(Segment::TrackService).to receive(:call).with(
        follow.user,
        'Follow Created',
        { 'Followable type' => 'Hashtag' }
      )

      described_class.new.perform(follow.id)
    end
  end

  context 'Followable is a community' do
    it 'calls the service' do
      follow = create(:follow, followable: create(:community))

      expect_any_instance_of(Segment::TrackService).to receive(:call).with(
        follow.user,
        'Follow Created',
        { 'Followable type' => 'Community' }
      )

      described_class.new.perform(follow.id)
    end
  end
end
